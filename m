Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5979450CE51
	for <lists+linux-arch@lfdr.de>; Sun, 24 Apr 2022 04:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237583AbiDXCHj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 23 Apr 2022 22:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237572AbiDXCH3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 23 Apr 2022 22:07:29 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A8A18B5A8;
        Sat, 23 Apr 2022 19:04:30 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-e2442907a1so12667198fac.8;
        Sat, 23 Apr 2022 19:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qBr50c7QhmXtEu90fc5Sm7CKo58o5R2uhRh8mh6nqdg=;
        b=dWmM8EKwAiDhChf255ASUvcvSHzc8i67xxisS0z/JSH31CSwACamEH6wPyuj7fiwZi
         1w+v1vg1Q6l+ao+SWot/rKwz0/IX7+lsT4F36Hvcdb98Qy3m+uwq1Jc6RaFQ7cjgiLuF
         /D5HPvDAa6MPry4hDR1Y15JLsrm8Te14P3/K7P/1AG84exw4POOh6O766F3xKoO0TX5+
         QyqI/b7HnWGCGNmRUia/BEoqDmGdow0zTksSvdFTJ1qVV3pjPHrEMV3Yhul50idgyCTw
         xJDlLGNx5NfSMDCIfUXAGVih82J7AGumI1Xf84ROcgBs+ppEXQs39HbZ6KxKByi9Kkfl
         ZCEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qBr50c7QhmXtEu90fc5Sm7CKo58o5R2uhRh8mh6nqdg=;
        b=CW7ejFxze/2BQYCNUY/zhMSybYeZd5FqLwnCBITbdJs+VdjbYBCkJvD8Fdkx5XXGWv
         ltasz7lO352q+aK3HhH4HYp560wGBoiTOw0+d+9zv30c+AgTY1hKRZ4a4dH1b6R6kVmq
         kuBVw2y0ClM1az2XMjSwrphHgu6A8vfO7xYLD79RSSfJO46KXmwbt0rKA5OlDFilrY5p
         XkL9Ivnx5rJvuPH5C50niOhcl3zlRawDPq1aPnUFoBHgpvbpoeq0BQziELnilmyzWOw5
         x8CSJvbXdm9gc7JYQG3gU08aDb1VVWksBjK608wtcv9MoUR1FXraBP9Vq1TyIrSEGMx8
         fWwA==
X-Gm-Message-State: AOAM531k2aWES9Qv2giOgY/xrPfQJ7Md1eKjOCJ7vKYdKgTWRkimH6Ax
        gS7R9ovV5Og+KF0XM3X+QAk=
X-Google-Smtp-Source: ABdhPJz5Byijxc9gnOpLV8xZF2j1Ud7rIp8oZQvhWydyR3xuNhChydtpMLh+sxvZhUR7cr4D0gyIWg==
X-Received: by 2002:a05:6870:2047:b0:e9:1b34:fbe with SMTP id l7-20020a056870204700b000e91b340fbemr1614036oad.64.1650765870043;
        Sat, 23 Apr 2022 19:04:30 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t6-20020a056870f20600b000e2a451bcaesm2186498oao.17.2022.04.23.19.04.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Apr 2022 19:04:29 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <5dfb14f4-23c6-1aa9-9ab3-bd5373ceaa64@roeck-us.net>
Date:   Sat, 23 Apr 2022 19:04:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v1] random: block in /dev/urandom
Content-Language: en-US
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Nick Hu <nickhu@andestech.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "David S . Miller" <davem@davemloft.net>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Michal Simek <monstr@monstr.eu>,
        Borislav Petkov <bp@alien8.de>, Guo Ren <guoren@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Joshua Kinard <kumba@gentoo.org>,
        David Laight <David.Laight@aculab.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Eric Biggers <ebiggers@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Theodore Ts'o <tytso@mit.edu>
References: <20220217162848.303601-1-Jason@zx2c4.com>
 <20220322155820.GA1745955@roeck-us.net> <YjoC5kQMqyC/3L5Y@zx2c4.com>
 <d5c23f68-30ba-a5eb-6bea-501736e79c88@roeck-us.net>
 <CAHmME9rmeQAD2DwG=APTmDxuVxFDH=6GXoKpgPrU9rc9oXrmxQ@mail.gmail.com>
 <20220423135631.GB3958174@roeck-us.net> <YmRrUYfsXkF3XZ5S@zx2c4.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <YmRrUYfsXkF3XZ5S@zx2c4.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 4/23/22 14:10, Jason A. Donenfeld wrote:
> Hey Guenter,
> 
> On Sat, Apr 23, 2022 at 06:56:31AM -0700, Guenter Roeck wrote:
>> Looks like your code is already in -next; I see the same failures in
>> your tree and there.
> 
> So interestingly, none of the old issues are now present (the hangs on
> versatilepb and such), so that's very positive. As for the crashes you
> found:
> 
>> openrisc generates a warning backtrace.
>> parisc crashes.
>> s390 crashes silently, no crash log.
> 
> I've now fixed these too, and tested the fixes as well. Hopefully the
> new jd/for-guenther branch has no regressions at all now... Knock on
> wood.
> 
> Thanks a bunch for looking at this. Very much appreciated.
> 

I'll run another test tonight.

Guenter
