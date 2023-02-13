Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07A0A693EF5
	for <lists+linux-arch@lfdr.de>; Mon, 13 Feb 2023 08:40:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbjBMHkH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 13 Feb 2023 02:40:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjBMHkG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 13 Feb 2023 02:40:06 -0500
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B87BE3AD;
        Sun, 12 Feb 2023 23:40:05 -0800 (PST)
Received: (Authenticated sender: alex@ghiti.fr)
        by mail.gandi.net (Postfix) with ESMTPSA id 657521C0002;
        Mon, 13 Feb 2023 07:40:02 +0000 (UTC)
Message-ID: <7dd732b9-d05d-1494-4624-c25d05c443b1@ghiti.fr>
Date:   Mon, 13 Feb 2023 08:40:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 00/24] Remove COMMAND_LINE_SIZE from uapi
To:     Arnd Bergmann <arnd@arndb.de>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-kernel@vger.kernel.org
References: <20221211061358.28035-1-palmer@rivosinc.com>
 <639b020c-7419-cbda-64c4-caffd8683131@ghiti.fr>
 <aa40847d-1814-4a20-821e-650c8f1f7cad@app.fastmail.com>
Content-Language: en-US
From:   Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <aa40847d-1814-4a20-821e-650c8f1f7cad@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


On 2/10/23 20:37, Arnd Bergmann wrote:
> On Fri, Feb 10, 2023, at 18:10, Alexandre Ghiti wrote:
>> On 12/11/22 07:13, Palmer Dabbelt wrote:
>>> This all came up in the context of increasing COMMAND_LINE_SIZE in the
>>> RISC-V port.  In theory that's a UABI break, as COMMAND_LINE_SIZE is the
>>> maximum length of /proc/cmdline and userspace could staticly rely on
>>> that to be correct.
>>>
>>> Usually I wouldn't mess around with changing this sort of thing, but
>>> PowerPC increased it with a5980d064fe2 ("powerpc: Bump COMMAND_LINE_SIZE
>>> to 2048").  There are also a handful of examples of COMMAND_LINE_SIZE
>>> increasing, but they're from before the UAPI split so I'm not quite sure
>>> what that means: e5a6a1c90948 ("powerpc: derive COMMAND_LINE_SIZE from
>>> asm-generic"), 684d2fd48e71 ("[S390] kernel: Append scpdata to kernel
>>> boot command line"), 22242681cff5 ("MIPS: Extend COMMAND_LINE_SIZE"),
>>> and 2b74b85693c7 ("sh: Derive COMMAND_LINE_SIZE from
>>> asm-generic/setup.h.").
>>>
>>> It seems to me like COMMAND_LINE_SIZE really just shouldn't have been
>>> part of the uapi to begin with, and userspace should be able to handle
>>> /proc/cmdline of whatever length it turns out to be.  I don't see any
>>> references to COMMAND_LINE_SIZE anywhere but Linux via a quick Google
>>> search, but that's not really enough to consider it unused on my end.
>>>
>>> The feedback on the v1 seemed to indicate that COMMAND_LINE_SIZE really
>>> shouldn't be part of uapi, so this now touches all the ports.  I've
>>> tried to split this all out and leave it bisectable, but I haven't
>>> tested it all that aggressively.
>>>
>>> Changes since v1 <https://lore.kernel.org/all/20210423025545.313965-1-palmer@dabbelt.com/>:
>>> * Touches every arch.
>>>
>>>
>> The command line size is still an issue on riscv, any comment on this so
>> we can make progress?
> I think this makes sense overall, but I see there were a couple
> of architecture specific regressions introduced in v2 that should
> be resolved, see
>
> https://lore.kernel.org/all/20221211061358.28035-1-palmer@rivosinc.com/


Thanks, I had not noticed those failures. I'll take over and send a v3 
that fixes that,

Thanks again,

Alex


>
> for the archive of this thread.
>
>       Arnd
