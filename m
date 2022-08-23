Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D232559EBC4
	for <lists+linux-arch@lfdr.de>; Tue, 23 Aug 2022 21:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbiHWTFz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 23 Aug 2022 15:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232656AbiHWTF1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 23 Aug 2022 15:05:27 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9370712B065
        for <linux-arch@vger.kernel.org>; Tue, 23 Aug 2022 10:41:21 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id r4so18950774edi.8
        for <linux-arch@vger.kernel.org>; Tue, 23 Aug 2022 10:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=L5vDksmX6kl63axC8fTX4W4UjA4ULlvaj4B5Lk9Uogw=;
        b=L+f8XLyA+qC3dl1BiCC63A2xsLWVaxkUCI8S39DAVQxI//2aOX6pcoVv2ZPow3f3tC
         cK4lPzuqIIdDHFHXKyO2KRbploN722Rcfnxi0O2cYIf2lTkK9Fw2w0sZDrK1Ee8IxrD+
         yU8xkJbWfAL0qZkeN4oSBiGVPBJpQQw9qv15o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=L5vDksmX6kl63axC8fTX4W4UjA4ULlvaj4B5Lk9Uogw=;
        b=FbaS06k0esZtlfp0cFk1HnC+bTkwmg3zqjcJRo+3Jvi+E3quqDtYXCeMHzS6c9dWr5
         X6G+J9+0pyc148xPiYDXFubsX7mcUFGg4ItQpYOsoMJe4gEGBWhQz5J9dNkvbWszKroY
         hMHWdcWnx1jjjwrwKi9JKscI7cppNWraUqUxMWuD/11YjJlg7tP0bv1zv19fWWXmwb1o
         z5FfoCm1TO2JvXNuHGaGMVBXhYyxjBEHgB8qROMjzKmNThAJ7OjHaa7iRs+MIm6aAnja
         k9+Znwau0PYLf6RBNpQpynzc5zcjh0hkASL143z2wyYJgBjimIB1clw89NwEVbJF434G
         yOhg==
X-Gm-Message-State: ACgBeo2xZ/i9h36fnCoaLSk1WHXUz6P8YRVs2VKycg48/PSYYlMGtCu/
        1mm+GeVL8NHvZq0MgBN/ZX7YWkiUtEAFlLmKoAc=
X-Google-Smtp-Source: AA6agR40hc6halzLU3KZsFwRE4SxTzN+Bb0MxPMszfs2xwww2geWpiMU7Ae36gwqa0YOO4GBkv+oMg==
X-Received: by 2002:a05:6402:42cb:b0:446:f112:4d38 with SMTP id i11-20020a05640242cb00b00446f1124d38mr4742923edc.221.1661276276192;
        Tue, 23 Aug 2022 10:37:56 -0700 (PDT)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com. [209.85.128.51])
        by smtp.gmail.com with ESMTPSA id kz3-20020a17090777c300b0073dafb227c0sm117146ejc.161.2022.08.23.10.37.55
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Aug 2022 10:37:55 -0700 (PDT)
Received: by mail-wm1-f51.google.com with SMTP id s23so7562338wmj.4
        for <linux-arch@vger.kernel.org>; Tue, 23 Aug 2022 10:37:55 -0700 (PDT)
X-Received: by 2002:a05:600c:3556:b0:3a6:220e:6242 with SMTP id
 i22-20020a05600c355600b003a6220e6242mr2799346wmq.145.1661276274837; Tue, 23
 Aug 2022 10:37:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAH2r5mtDFpaAWeGCtrfm_WPM6j-Gkt_O80=nKfp6y39aXaBr6w@mail.gmail.com>
 <CAHk-=wi+xbVq++uqW9YgWpHjyBHNB8a-xad+Xp23-B+eodLCEA@mail.gmail.com> <YwSWLH4Wp6yDMeKf@arm.com>
In-Reply-To: <YwSWLH4Wp6yDMeKf@arm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 23 Aug 2022 10:37:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=whU7QiwWeO81Rf+KGh0rGS9CEfKUXc5eik+Z0GaVJgu4A@mail.gmail.com>
Message-ID: <CAHk-=whU7QiwWeO81Rf+KGh0rGS9CEfKUXc5eik+Z0GaVJgu4A@mail.gmail.com>
Subject: Re: strlcpy() notes (was Re: [GIT PULL] smb3 client fixes)
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Steve French <smfrench@gmail.com>,
        CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Aug 23, 2022 at 1:56 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> With load_unaligned_zeropad(), the arm64 implementation disables tag
> checking temporarily. We could do the same with read_word_at_a_time()
> (there is a kasan_check_read() in this function but it wrongly uses a
> size of 1).

The "size of 1" is not wrong, it's intentional, exactly because people
do things like

    strscpy(dst, "string", sizeof(dst));

which is a bit unfortunate, but very understandable and intended to
work. So that thing may over-read the string by up to a word. And
KASAN ends up being unhappy.

            Linus
