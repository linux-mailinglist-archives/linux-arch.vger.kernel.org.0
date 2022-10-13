Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 149E85FD941
	for <lists+linux-arch@lfdr.de>; Thu, 13 Oct 2022 14:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbiJMMg5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 13 Oct 2022 08:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiJMMgz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 13 Oct 2022 08:36:55 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D44F911E46C;
        Thu, 13 Oct 2022 05:36:53 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1oixSC-00069y-7l; Thu, 13 Oct 2022 14:36:48 +0200
Message-ID: <3c7c22f1-2e9d-8bdc-33b7-eb8dcb8a3593@leemhuis.info>
Date:   Thu, 13 Oct 2022 14:36:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Content-Language: en-US, de-DE
To:     regressions@lists.linux.dev, Guenter Roeck <linux@roeck-us.net>
Cc:     linux-alpha@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Linux-Arch <linux-arch@vger.kernel.org>
References: <20220818092059.103884-1-linus.walleij@linaro.org>
 <20221002224521.GA968453@roeck-us.net>
 <fd905ca5-fe0d-4cfb-a0d0-aea8af539cc7@app.fastmail.com>
 <57200020-c460-74ec-c786-9a2c16f4870e@roeck-us.net>
 <2e110666-7519-4693-8a89-240cbb118c7e@app.fastmail.com>
 <20221012140519.GA2405113@roeck-us.net>
 <e99d33ff-4bfe-4727-a5ca-f4987b871ccd@app.fastmail.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: [PATCH] alpha: Use generic <asm-generic/io.h> #forregzbot
In-Reply-To: <e99d33ff-4bfe-4727-a5ca-f4987b871ccd@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1665664613;f968989d;
X-HE-SMSGID: 1oixSC-00069y-7l
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

[Note: this mail is primarily send for documentation purposes and/or for
regzbot, my Linux kernel regression tracking bot. That's why I removed
most or all folks from the list of recipients, but left any that looked
like a mailing lists. These mails usually contain '#forregzbot' in the
subject, to make them easy to spot and filter out.]

On 12.10.22 17:32, Arnd Bergmann wrote:
> On Wed, Oct 12, 2022, at 4:05 PM, Guenter Roeck wrote:
>> On Tue, Oct 04, 2022 at 10:28:24PM +0200, Arnd Bergmann wrote:
>> Unfortunately that did not completely fix the problem, or maybe the fix got
>> lost. In mainline, when building alpha:allnoconfig:
>>
>> arch/alpha/kernel/core_marvel.c:807:1: error: expected '=', ',', ';', 
>> 'asm' or '__attribute__' before 'marvel_ioread8'
>>   807 | marvel_ioread8(const void __iomem *xaddr)
>>
>> The code is:
>>
>> unsigned u8
>> marvel_ioread8(const void __iomem *xaddr)
>>
>> The compiler doesn't like "unsigned u8".
> 
> Right, I fixed up a different bug and introduced this wrong type.
> I didn't catch my mistake until after the pull request was
> merged, but fixed it in
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git/commit/?id=2e21c1575208
> 
> which should be in linux-next. I was giving it a little more
> time to be see if there are any other regressions I caused.

In that case:

#regzbot fixed-by: 2e21c157520

Ciao, Thorsten
