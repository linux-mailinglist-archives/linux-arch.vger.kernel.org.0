Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 948F5643CF4
	for <lists+linux-arch@lfdr.de>; Tue,  6 Dec 2022 07:02:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233571AbiLFGCF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Dec 2022 01:02:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233084AbiLFGCC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Dec 2022 01:02:02 -0500
Received: from 189.cn (ptr.189.cn [183.61.185.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7519527157;
        Mon,  5 Dec 2022 22:01:57 -0800 (PST)
HMM_SOURCE_IP: 10.64.8.43:55518.1873184978
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-123.150.8.42 (unknown [10.64.8.43])
        by 189.cn (HERMES) with SMTP id 25246100302;
        Tue,  6 Dec 2022 14:01:54 +0800 (CST)
Received: from  ([123.150.8.42])
        by gateway-153622-dep-6cffbd87dd-f7vjc with ESMTP id 5f66b60e48754f84901a8e6e8468e94a for arnd@arndb.de;
        Tue, 06 Dec 2022 14:01:55 CST
X-Transaction-ID: 5f66b60e48754f84901a8e6e8468e94a
X-Real-From: chensong_2000@189.cn
X-Receive-IP: 123.150.8.42
X-MEDUSA-Status: 0
Sender: chensong_2000@189.cn
Message-ID: <0903321f-e0cf-fd7b-bbdd-fc4fdc0f05a0@189.cn>
Date:   Tue, 6 Dec 2022 14:01:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3 3/4] include/asm-generic/io.h: remove performing
 pointer arithmetic on a null pointer
To:     Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>
References: <1670229006-4063-1-git-send-email-chensong_2000@189.cn>
 <2a3d3359-a5fd-453b-81f1-35c7a35fc12d@app.fastmail.com>
Content-Language: en-US
From:   Song Chen <chensong_2000@189.cn>
In-Reply-To: <2a3d3359-a5fd-453b-81f1-35c7a35fc12d@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

在 2022/12/5 18:04, Arnd Bergmann 写道:
> On Mon, Dec 5, 2022, at 09:30, Song Chen wrote:
>> kernel test robot reports below warnings:
>>
>>     In file included from kernel/trace/trace_events_synth.c:18:
>>     In file included from include/linux/trace_events.h:9:
>>     In file included from include/linux/hardirq.h:11:
>>     In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
>>     In file included from include/asm-generic/hardirq.h:17:
>>     In file included from include/linux/irq.h:20:
>>     In file included from include/linux/io.h:13:
>>     In file included from arch/hexagon/include/asm/io.h:334:
>>     include/asm-generic/io.h:547:31: warning: performing pointer arithmetic
>> 	on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>>             val = __raw_readb(PCI_IOBASE + addr);
>>                               ~~~~~~~~~~ ^
>>     include/asm-generic/io.h:560:61: warning: performing pointer arithmetic
>> 	on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>>             val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
>>                                                             ~~~~~~~~~~ ^
>>     include/uapi/linux/byteorder/little_endian.h:37:51: note:
>> 		expanded from macro '__le16_to_cpu'
>>     #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
>>
>> The reason could be constant literal zero converted to any pointer type decays
>> into the null pointer constant.
>>
>> I'm not sure why those warnings are only triggered when building hexagon instead
>> of x86 or arm, but anyway, i found a work around:
>>
>> 	void *pci_iobase = PCI_IOBASE;
>> 	val = __raw_readb(pci_iobase + addr);
>>
>> The pointer is not evaluated at compile time, so the warnings are removed.
>>
>> Signed-off-by: Song Chen <chensong_2000@189.cn>
>> Reported-by: kernel test robot <lkp@intel.com>
> 
> The code is still wrong, you just hide the warning, so no, this is
> not a correct fix. When PCI_IOBASE is NULL, any call to
> inb() etc is a NULL pointer dereference that immediately crashes
> the kernel, so the correct solution is to not allow building code
> that uses port I/O on kernels that are configured not to
> support port I/O.
> 
> We have discussed this bit multiple times, and Niklas Schnelle
> last posted his series to fix this as an RFC in [1].
> 
>        Arnd
> 
> [1] https://lore.kernel.org/lkml/20220429135108.2781579-1-schnelle@linux.ibm.com/
> 

Trace triggers the warning accidentally by including io.h indirectly 
because of the absence of PCI_IOBASE in hexagon. So what trace can do in 
this case is either to suppress warning or just ignore it, the warning 
will go away as long as hexagon has put PCI_IOBASE in place or 
implemented its own inb() etc, i think they will do it sooner or later.

Introducing HAS_IOPORT to trace seems no necessary and too much impact.

/Song
