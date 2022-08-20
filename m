Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5820F59AF70
	for <lists+linux-arch@lfdr.de>; Sat, 20 Aug 2022 20:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbiHTSOk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 20 Aug 2022 14:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbiHTSOj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 20 Aug 2022 14:14:39 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6544D2CE23
        for <linux-arch@vger.kernel.org>; Sat, 20 Aug 2022 11:14:38 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id e21so4291371edc.7
        for <linux-arch@vger.kernel.org>; Sat, 20 Aug 2022 11:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=fJ+mgjT2uor3fzF3w2fg4p4jIoUEQwunlNQlMHXLtCo=;
        b=UH0lhrTxgMvxau9HlVNw7CrHSJHpWNx7MZAhuOFwYCRGrGSK3ODQtb0w2OIG5iqNrx
         S+BA6HtGY5kb+dm0kJaBA9V7+7EsEkkxiV4gbSzOk29NLI3IQvIOP19aZLmcvQ+A6yaW
         77fSnn8ARLp5NWuGqWliQ/mB+sY/en6QO+R5o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=fJ+mgjT2uor3fzF3w2fg4p4jIoUEQwunlNQlMHXLtCo=;
        b=NX7cUEVM1zR++EPdeZEixCZXTfhz2iJZcNDUgfWU8C1JKzjPCjidrmOEdcYxoa+EWt
         RQQ2sePGIZXEPLob7oBGuDMPpIp4LokarNbG3+M6jDunvfvVWAf209QprK006UrOgZJP
         sx6npZGNABpGeFT/oAAQA0V5XDHLIyFedqRrBf8SRARwTXF8SgaAta0s2iHKBTf/JOzk
         IMBe7GzaJNGSsafpjXT422pd8jnm2WLYI8dgZdMJAff9jVfUpL7ZU7w2pdLu1R12OAuK
         zXAYJ7oDv5X34zL2vhy/jCg2u2U2vJiIHgUQEeN6PA0s8OfiA384qAWQHCdK7Uci4quT
         69qA==
X-Gm-Message-State: ACgBeo371CNI5xrWP8X3aBh0o5O9tjh7lonjeORzaDIdUCZK7fhfNS8e
        zeCVl4fx8rxws1tLBiwgllU7+LulN45UXkWM
X-Google-Smtp-Source: AA6agR7SmLZUnqyeODie5XGhTKX1QYr74AQjHtlDPlfQp9WzyGxOy98+IOSqidIZgUQ+Eqahjw5LFg==
X-Received: by 2002:a05:6402:4312:b0:43d:b9c0:65ee with SMTP id m18-20020a056402431200b0043db9c065eemr10419468edc.205.1661019276701;
        Sat, 20 Aug 2022 11:14:36 -0700 (PDT)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com. [209.85.221.54])
        by smtp.gmail.com with ESMTPSA id d6-20020a1709063ec600b007389c5a45f0sm417635ejj.148.2022.08.20.11.14.35
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Aug 2022 11:14:35 -0700 (PDT)
Received: by mail-wr1-f54.google.com with SMTP id r16so8580976wrm.6
        for <linux-arch@vger.kernel.org>; Sat, 20 Aug 2022 11:14:35 -0700 (PDT)
X-Received: by 2002:a05:6000:1888:b0:222:ca41:dc26 with SMTP id
 a8-20020a056000188800b00222ca41dc26mr6619808wri.442.1661019275424; Sat, 20
 Aug 2022 11:14:35 -0700 (PDT)
MIME-Version: 1.0
References: <YwBWJYU9BjnGBy2c@ZenIV>
In-Reply-To: <YwBWJYU9BjnGBy2c@ZenIV>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 20 Aug 2022 11:14:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=whL7nCkQLwWG29c-ojeCPqbaHPsRzOxEoxO0HzLuZV+sw@mail.gmail.com>
Message-ID: <CAHk-=whL7nCkQLwWG29c-ojeCPqbaHPsRzOxEoxO0HzLuZV+sw@mail.gmail.com>
Subject: Re: [RFC][PATCHES] termios.h cleanups
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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

On Fri, Aug 19, 2022 at 8:34 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> It takes the helpers and INIT_C_CC into new header (termios-internal.h),
> with defaults being in linux/termios-internal.h, unless an arch-specific
> variant is provided in asm/termios-internal.h (only alpha and sparc end
> up needing that).  Files that need that stuff (all 4 of them) include
> linux/termios-internal.h.

I don't see anything obviously wrong here, and my main reaction is
actually that I wish this went a bit further, and moved the whole
kernel_termios_to_user_termios stuff into C code rather than having
them in headers.

I don't think it's really worth inlining those things, and I wonder if
we could just have the default "just copy directly to/from user space"
as __weak functions, and then allow sparc and alpha to override them?

              Linus
