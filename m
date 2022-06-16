Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C47E054D9FA
	for <lists+linux-arch@lfdr.de>; Thu, 16 Jun 2022 07:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348676AbiFPFtE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 16 Jun 2022 01:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiFPFtD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 16 Jun 2022 01:49:03 -0400
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B845D5B8A1;
        Wed, 15 Jun 2022 22:49:02 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id o7so763669eja.1;
        Wed, 15 Jun 2022 22:49:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2aLyJ9nuinCimwT80iv0uqjCDdiMiOsD8JMaFZPN2jc=;
        b=CIPD1irzWymApegaoxjvjur2zymqxzi+2U9LT8OmeXGJ5W+NlMI0Kv/A9zx+AC3plA
         /vn09chL3OAjfdeefRrTJvrgQzVRpEzNTrT8ownlfWMyEKbKPBInODVEWbtKZ+kDmnQK
         XC0xDsH27sgdYT9rLZqncw7eGMmfAbrV4hgyjqiC4Y2tRQNT9AQfnWDfW6+g+M7aiFOc
         YGvARglA+ntIlD0bFnrVgs3njRoVB38Q1Gg2hCZK+69PctfIkk0dmyCc53KN10GqGZMy
         lKb6KopYrZuibrcrP7/V6vhqX788BFoLZgiaiiKOpfV6EgToaK4ztsp5qtkef+h9/nd6
         rl7g==
X-Gm-Message-State: AJIora92Oof4jrA3z1Ev+S9MkroX/j55QOsjTCTuD/e+kWVEKWIsSUit
        Ck5M+ltALW/0CdJ+xLdHZMo=
X-Google-Smtp-Source: AGRyM1vjlFZPdL9JPMwyXIXYk6FbCyEkJJLFrBU67z3e6uvGzso9Ey7SC1Ab+KqVljeIIbn1GiDVLA==
X-Received: by 2002:a17:906:74d1:b0:712:2293:8f41 with SMTP id z17-20020a17090674d100b0071222938f41mr2896433ejl.495.1655358541178;
        Wed, 15 Jun 2022 22:49:01 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id c26-20020a170906171a00b006fed9a0eb17sm305138eje.187.2022.06.15.22.48.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jun 2022 22:49:00 -0700 (PDT)
Message-ID: <c0996d75-070e-21e6-eb51-a10a358dbb46@kernel.org>
Date:   Thu, 16 Jun 2022 07:48:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v7 5/6] serial: Support for RS-485 multipoint addresses
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-serial <linux-serial@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Arnd Bergmann <arnd@arndb.de>, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org,
        Lukas Wunner <lukas@wunner.de>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        linux-api@vger.kernel.org
References: <20220615124829.34516-1-ilpo.jarvinen@linux.intel.com>
 <20220615124829.34516-6-ilpo.jarvinen@linux.intel.com>
 <Yqno+b/+W2RP8rnh@smile.fi.intel.com>
 <ae5c2e50-1a19-7a8f-7dbf-d7ef84128be6@linux.intel.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <ae5c2e50-1a19-7a8f-7dbf-d7ef84128be6@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 16. 06. 22, 7:04, Ilpo Järvinen wrote:
> On Wed, 15 Jun 2022, Andy Shevchenko wrote:
> 
>> On Wed, Jun 15, 2022 at 03:48:28PM +0300, Ilpo Järvinen wrote:
>>> Add support for RS-485 multipoint addressing using 9th bit [*]. The
>>> addressing mode is configured through .rs485_config().
>>>
>>> ADDRB in termios indicates 9th bit addressing mode is enabled. In this
>>> mode, 9th bit is used to indicate an address (byte) within the
>>> communication line. ADDRB can only be enabled/disabled through
>>> .rs485_config() that is also responsible for setting the destination and
>>> receiver (filter) addresses.
>>>
>>> [*] Technically, RS485 is just an electronic spec and does not itself
>>> specify the 9th bit addressing mode but 9th bit seems at least
>>> "semi-standard" way to do addressing with RS485.
>>>
>>> Cc: Arnd Bergmann <arnd@arndb.de>
>>> Cc: Jonathan Corbet <corbet@lwn.net>
>>> Cc: linux-api@vger.kernel.org
>>> Cc: linux-doc@vger.kernel.org
>>> Cc: linux-kernel@vger.kernel.org
>>> Cc: linux-arch@vger.kernel.org
>>
>> Hmm... In order to reduce commit messages you can move these Cc:s after the
>> cutter line ('---').
> 
> Ok, although the toolchain I use didn't support preserving --- content
> so I had to create hack to preserve them, hopefully nothing backfires due
> to the hack. :-)
> 
>>> -	__u32	padding[5];		/* Memory is cheap, new structs
>>> -					   are a royal PITA .. */
>>> +	__u8	addr_recv;
>>> +	__u8	addr_dest;
>>> +	__u8	padding[2 + 4 * sizeof(__u32)];		/* Memory is cheap, new structs
>>> +							 * are a royal PITA .. */
>>
>> I'm not sure it's an equivalent. I would leave u32 members  untouched, so
>> something like
>>
>> 	__u8	addr_recv;
>> 	__u8	addr_dest;
>> 	__u8	padding0[2];		/* Memory is cheap, new structs
>> 	__u32	padding1[4];		 * are a royal PITA .. */
>>
>> And repeating about `pahole` tool which may be useful here to check for ABI
>> potential changes.
> 
> I cannot take __u32 padding[] away like that, this is an uapi header.

Yeah, but it's padding after all. I would personally break it for 
example as Andy suggests (if pahole shows no differences in size on both 
32/64 bit) and wait if something breaks. To be honest, I'd not expect 
anyone to touch it. And if someone does, we would fix it somehow and 
they should too...

thanks,
-- 
js
suse labs
