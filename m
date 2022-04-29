Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E338514D30
	for <lists+linux-arch@lfdr.de>; Fri, 29 Apr 2022 16:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377478AbiD2OhS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 Apr 2022 10:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377468AbiD2OhP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 Apr 2022 10:37:15 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4753CA88B3
        for <linux-arch@vger.kernel.org>; Fri, 29 Apr 2022 07:33:55 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1nkRgt-00042Z-F1; Fri, 29 Apr 2022 16:33:51 +0200
Message-ID: <ff7605de-fe12-3bbf-cce9-aec18be9d54e@pengutronix.de>
Date:   Fri, 29 Apr 2022 16:33:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Subject: Re: [RFC v2 04/39] char: impi, tpm: depend on HAS_IOPORT
To:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        Corey Minyard <minyard@acm.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        "moderated list:IPMI SUBSYSTEM" 
        <openipmi-developer@lists.sourceforge.net>,
        "open list:TPM DEVICE DRIVER" <linux-integrity@vger.kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
References: <20220429135108.2781579-1-schnelle@linux.ibm.com>
 <20220429135108.2781579-7-schnelle@linux.ibm.com>
 <07c39877d9e940a96be41e21e22fe45dbb73d949.camel@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <07c39877d9e940a96be41e21e22fe45dbb73d949.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arch@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hello Niklas,

On 29.04.22 16:23, Niklas Schnelle wrote:
>> Hello Niklas,
>>
>> On 29.04.22 15:50, Niklas Schnelle wrote:
>>> In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
>>> not being declared. We thus need to add this dependency and ifdef
>>> sections of code using inb()/outb() as alternative access methods.
>>>
>>> Co-developed-by: Arnd Bergmann <arnd@kernel.org>
>>> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
>>
>> [snip]
>>
>>> diff --git a/drivers/char/tpm/tpm_infineon.c b/drivers/char/tpm/tpm_infineon.c
>>> index 9c924a1440a9..2d2ae37153ba 100644
>>> --- a/drivers/char/tpm/tpm_infineon.c
>>> +++ b/drivers/char/tpm/tpm_infineon.c
>>> @@ -51,34 +51,40 @@ static struct tpm_inf_dev tpm_dev;
>>>  
>>>  static inline void tpm_data_out(unsigned char data, unsigned char offset)
>>>  {
>>> +#ifdef CONFIG_HAS_IOPORT
>>>       if (tpm_dev.iotype == TPM_INF_IO_PORT)
>>>               outb(data, tpm_dev.data_regs + offset);
>>>       else
>>> +#endif
>>
>> This looks ugly. Can't you declare inb/outb anyway and skip the definition,
>> so you can use IS_ENABLED() here instead?
>>
>> You can mark the declarations with __compiletime_error("some message"), so
>> if an IS_ENABLED() reference is not removed at compile time, you get some
>> readable error message instead of a link error.
>>
>> Cheers,
>> Ahmad
> 
> I didn't know about __compiletime_error() that certainly sounds
> interesting even when using a normal #ifdef.
> 
> That said either with the function not being declared or this
> __compiletime_error() mechanism I would think that using IS_ENABLED()
> relies on compiler optimizations not to compile in the missing/error
> function call, right? I'm not sure if that is something we should do.

Yes, it assumes your compiler is able to discard the body of an if (0),
which we already assume, otherwise it wouldn't make sense for any existing
code to use __compiletime_error().

To me this sounds much cleaner than #ifdefs in the midst of functions,
which are a detriment to maintainability.

Cheers,
Ahmad




> 
> 


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
