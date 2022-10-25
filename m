Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9975060D4A1
	for <lists+linux-arch@lfdr.de>; Tue, 25 Oct 2022 21:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbiJYTWz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 25 Oct 2022 15:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbiJYTWt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 25 Oct 2022 15:22:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB62B1B81;
        Tue, 25 Oct 2022 12:22:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C10361AF5;
        Tue, 25 Oct 2022 19:22:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD7FDC433C1;
        Tue, 25 Oct 2022 19:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666725767;
        bh=ftFE81qWKNF97F1+cBxFeqLoApotXUldU+KauLM18kg=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=UwqgP6us0tlufLoD0tWGWtVkoYygJXXt0/XrmsC3fpjKUm5EDIq/AkzAvEWDEpmfU
         8YaD/C/pqjsmcpVeKkc+ywUp5xVqklZnGGgwMNP89V6tb0cJMmjy4OL8Nkl57B/xsb
         G6oVYLvuqgDV00UyUWobFEcQX4IgNlLQ4oTShMff68u3VkYGSVwd2RrMXI7pqPfOCK
         6JBrvkrTMM/dRgG9FRzIIxOHMNE0qe6sSZIcKGPfFWpt/Mnjgqeqm59MGqn1tBB/VT
         Gq2yM6aH6tQNyXps4PJ0CqAXES6QhqSZcpm6aufPVJmub1it3NDXFsx0e9XOb0UN+I
         AsskWC4Sg1ScA==
From:   Kalle Valo <kvalo@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-toolchains@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Larry Finger <Larry.Finger@lwfinger.net>, mikem@ring3k.org,
        wlanfae@realtek.com
Subject: Re: [PATCH v2] kbuild: treat char as always unsigned
References: <Y1BcpXAjR4tmV6RQ@zx2c4.com>
        <20221019203034.3795710-1-Jason@zx2c4.com> <Y1ZZyP4ZRBIbv+Kg@kili>
        <Y1ZbI4IzAOaNwhoD@kadam> <Y1a+cHkFt54gJv54@zx2c4.com>
        <CAHk-=wgK3Vs+7Kor-SisRHJYzV1tXD+=D4+W1XkfHOV2KN_OGw@mail.gmail.com>
        <CAHmME9ox7JNqOOZHEHCgaS95rsn-dVr4QOnN1mfmFEn=i9_jvw@mail.gmail.com>
Date:   Tue, 25 Oct 2022 22:22:41 +0300
In-Reply-To: <CAHmME9ox7JNqOOZHEHCgaS95rsn-dVr4QOnN1mfmFEn=i9_jvw@mail.gmail.com>
        (Jason A. Donenfeld's message of "Mon, 24 Oct 2022 19:17:25 +0200")
Message-ID: <874jvrzp1a.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

"Jason A. Donenfeld" <Jason@zx2c4.com> writes:

> Hi Linus,
>
> On Mon, Oct 24, 2022 at 7:11 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>> IOW, I don't think these are 6.1 material as some kind of obvious
>> fixes, at least not without driver author acks.
>
> Right, these are posted to the authors and maintainers to look at.
> Maybe they punt them until 6.2 which would be fine too.
>
>> On Mon, Oct 24, 2022 at 9:34 AM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>> Some of those may need more thought. For example, that first one:
>>
>> > https://lore.kernel.org/all/20221024163005.536097-1-Jason@zx2c4.com
>>
>> looks just *strange*. As far as I can tell, no other wireless drivers
>> do any sign checks at all.
>>
>> Now, I didn't really look around a lot, but looking at a few other
>> SIOCSIWESSID users, most don't even seem to treat it as a string at
>> all, but as just a byte dump (so memcpy() instead of strncpy())

Yes, SSID should be handled as a byte array with a specified length.
Back in the day some badly written code treated it as string but luckily
it's rare now.

>> As far as I know, there are no actual rules for SSID character sets,
>> and while using utf-8 or something else might cause interoperability
>> problems, this driver seems to be just confused. If you want to check
>> for "printable characters", that check is still wrong.
>>
>> So I don't think this is a "assume char is signed" issue. I think this
>> is a "driver is confused" issue.
>
> Yea I had a few versions of this. In one of them, I changed `char
> *extra` throughout the wireless stack into `s8 *extra` and in another
> `u8 *extra`, after realizing they're mostly just bags of bits. But
> that seemed pretty invasive when, indeed, this staging driver is just
> a little screwy.
>
> So perhaps the right fix is to just kill that whole snippet? Kalle - opinions?

I would also remove the whole 'extra[i] < 0', seems like a pointless
check to me. And I see that you already submitted v2, good.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
