Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 018135A2217
	for <lists+linux-arch@lfdr.de>; Fri, 26 Aug 2022 09:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245527AbiHZHkl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 26 Aug 2022 03:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245393AbiHZHk0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 26 Aug 2022 03:40:26 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BCC16DAD9
        for <linux-arch@vger.kernel.org>; Fri, 26 Aug 2022 00:40:24 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id bq23so940217lfb.7
        for <linux-arch@vger.kernel.org>; Fri, 26 Aug 2022 00:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=SWG+AYYaD3CGqVmhJUkc0npDBvTLvT/qXBQNeQdRPPI=;
        b=VavM614ow0Wq5WTGNBaTek9R2gSqCSK2LowLKioZCjH9fi0rLESL9gU51h6u1ICdVM
         O54wO0xGy8NLlu+JxKeFrsTK5D6TMHGLwWPXbcToifiej4CvHspsXtqeC5ShKEruaDem
         2VWI9zZ+ad+AeT/jOq3cAhJOGxL7TuGKXf1GA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=SWG+AYYaD3CGqVmhJUkc0npDBvTLvT/qXBQNeQdRPPI=;
        b=lQW+MNWLdhx1wW/yM6XQAO/2gBGiXiP9iV8IHO/Cs4WwKMJ+BXwq33of7l1RqM6qNN
         gmPAi9PHHwo/yyAyCfMkPgTppRu4oxemMD0Wc58v4G35HkX6SAmf84Dp/MvOwXcY5iRm
         aQcloF+XoGzxA7NCjS3jTc9n0DT0JmZLQP8GIoHOYLG94kX61WBsftgv1xHD16LGq9Li
         azaL2Kz349IQOBK4gioUngkX+92HQIXawad9oa0lQdxZO/EK0ODS+zjtov1JteubOTQi
         UxKG1kJi8rVQLmultW1EpEsWnjD0EhRLfD7z9anhYytpz2oTnkjevJZiPHE2D7cJtADx
         roBg==
X-Gm-Message-State: ACgBeo38W6Cozpjaup/8qTu1t1/yCGURxChj2pTlh51o/JptVtpomkZM
        zm+8cweB6NUovr3Ac1i5H1gJPA==
X-Google-Smtp-Source: AA6agR5Wm1zWSG4SC+mpBPzTyeIPT/0fZuyJYI07D9p9QGCLhhs/GEofhI1B8Us/Ffey/8A1d/hh1Q==
X-Received: by 2002:a19:645c:0:b0:492:cf78:62de with SMTP id b28-20020a19645c000000b00492cf7862demr1925671lfj.263.1661499622588;
        Fri, 26 Aug 2022 00:40:22 -0700 (PDT)
Received: from [172.16.11.74] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id q15-20020ac24a6f000000b0048b3926351bsm293857lfp.56.2022.08.26.00.40.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Aug 2022 00:40:21 -0700 (PDT)
Message-ID: <527eee19-532f-b2e7-a42f-a1e199094fbe@rasmusvillemoes.dk>
Date:   Fri, 26 Aug 2022 09:40:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: strlcpy() notes (was Re: [GIT PULL] smb3 client fixes)
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Steve French <smfrench@gmail.com>,
        CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
References: <CAH2r5mtDFpaAWeGCtrfm_WPM6j-Gkt_O80=nKfp6y39aXaBr6w@mail.gmail.com>
 <CAHk-=wi+xbVq++uqW9YgWpHjyBHNB8a-xad+Xp23-B+eodLCEA@mail.gmail.com>
 <YwSWLH4Wp6yDMeKf@arm.com>
 <CAHk-=whU7QiwWeO81Rf+KGh0rGS9CEfKUXc5eik+Z0GaVJgu4A@mail.gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <CAHk-=whU7QiwWeO81Rf+KGh0rGS9CEfKUXc5eik+Z0GaVJgu4A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 23/08/2022 19.37, Linus Torvalds wrote:
> On Tue, Aug 23, 2022 at 1:56 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
>>
>> With load_unaligned_zeropad(), the arm64 implementation disables tag
>> checking temporarily. We could do the same with read_word_at_a_time()
>> (there is a kasan_check_read() in this function but it wrongly uses a
>> size of 1).
> 
> The "size of 1" is not wrong, it's intentional, exactly because people
> do things like
> 
>     strscpy(dst, "string", sizeof(dst));
> 
> which is a bit unfortunate, but very understandable and intended to
> work. So that thing may over-read the string by up to a word. And
> KASAN ends up being unhappy.

So, while we're doing all the churn of replacing strlcpy anyway, may I
once again suggest we add (name can be bikeshedded) literal_strcpy():

#define literal_strcpy(d, s) ({ \
  static_assert(__same_type(d, char[]), "destination must be char array"); \
  static_assert(__same_type(s, const char[]), "source must be a string
literal"); \
  static_assert(sizeof(d) >= sizeof("" s ""), "source does not fit in
destination"); \
  strcpy(d, s); \
})

That interface _cannot_ be misused, because all the checking happens at
build time, including enforcement that the source really is a string
literal (the "" s "" trick - but for nicer error message the
static_assert on the previous line is there as well). So unlike all the
uses of str[ls]cpy which don't check the return value, we cannot
silently do a truncated copy. Also, if somebody down the line changes
the size of the destination or the literal string, again it will be
caught at build time.

And since gcc knows the semantics of strcpy(), it will also generate
better code, because it will usually not emit a call at all (or even put
the string in .rodata); it will simply emit a series of "mov immediate"
instructions.

Sloppy grepping for places where that could be used shows around ~800
places.

Btw, Steve, since you're incidentally on cc here anyway, perhaps you
want to take a look at

  strscpy(extension, "___", strlen("___"));

and see if this really just wants two underscores copied to extension.

Rasmus
