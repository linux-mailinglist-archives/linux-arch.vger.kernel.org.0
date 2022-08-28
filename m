Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2935A3DED
	for <lists+linux-arch@lfdr.de>; Sun, 28 Aug 2022 16:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbiH1OAi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 28 Aug 2022 10:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiH1OAe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 28 Aug 2022 10:00:34 -0400
Received: from conssluserg-04.nifty.com (conssluserg-04.nifty.com [210.131.2.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE5AD12A;
        Sun, 28 Aug 2022 07:00:32 -0700 (PDT)
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 27SE0JA4019945;
        Sun, 28 Aug 2022 23:00:19 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 27SE0JA4019945
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1661695219;
        bh=E9rWh6cQtF+KpJLfWwXtqrqWDjD/vKIz6Ga3nB6xPh4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WjuxRLDPHkfBc/dd4RNCInM+RAFs2PwzQVgkYdhgx1V/7tyTsYVK5NuD4wmA3DaNv
         kXQObz+1+q4iBGoPpuOZXfuongTYXL+37ohevY/fQbl4zopT03eN+S+gZdWhPw++4J
         yjQxdf63B7/UaSXfvzuXHqiKP8wRXSGs7pAUGW9NOvm71IVo7TR6JJY7bacLDGzx/T
         8+P4EJS5uNv9JzOaGACHJzcAOu5VkldDtblWlMNV35HA/hJ7V7mRJsQxAx99Z1yfNl
         Tili0AtM5pi1+f42jvBrfNRe/QsrEGWpeRx3zi50BGcJ1DmrZ7IPk72PGv18fkFPr0
         ugqtWQrbhktIA==
X-Nifty-SrcIP: [209.85.167.177]
Received: by mail-oi1-f177.google.com with SMTP id r124so7678173oig.11;
        Sun, 28 Aug 2022 07:00:19 -0700 (PDT)
X-Gm-Message-State: ACgBeo0yKd84QWZkEJPWlykJohwgMRAZnKtPu/1/Buab6lcsHZHNyfSG
        QyJeEapZrkQX4ORA1XjnnBI21apbyrC13sgs+vE=
X-Google-Smtp-Source: AA6agR5EkiJ1fe36qEtDYYDu0Nt0DM0xDvkra63z5irBVebjc1EFBlY7qkkEE8l5R0hgIPRlVYuFHJ9NSzx+oJmdMw8=
X-Received: by 2002:a05:6808:2099:b0:343:49f5:5300 with SMTP id
 s25-20020a056808209900b0034349f55300mr5198934oiw.287.1661695218338; Sun, 28
 Aug 2022 07:00:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220817161438.32039-2-ysionneau@kalray.eu> <31ce5305-a76b-13d7-ea55-afca82c46cf2@kalray.eu>
 <CAMj1kXF8mZ_pK38T=dCU6Rewqq23pPM5HwnZHyx1cGgo0F7Mew@mail.gmail.com> <fbf47f7c-7d42-4510-6dd4-92f46ec70819@kalray.eu>
In-Reply-To: <fbf47f7c-7d42-4510-6dd4-92f46ec70819@kalray.eu>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 28 Aug 2022 22:59:42 +0900
X-Gmail-Original-Message-ID: <CAK7LNARfwLjoEeJ=s5VSi9tbA0wBSzR93--OnZh0oGfvuvw_9w@mail.gmail.com>
Message-ID: <CAK7LNARfwLjoEeJ=s5VSi9tbA0wBSzR93--OnZh0oGfvuvw_9w@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] Fix __kcrctab+* sections alignment
To:     Yann Sionneau <ysionneau@kalray.eu>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Aug 25, 2022 at 9:21 PM Yann Sionneau <ysionneau@kalray.eu> wrote:
>
> Hello Ard,
>
> On 25/08/2022 14:12, Ard Biesheuvel wrote:
> > On Thu, 25 Aug 2022 at 14:10, Yann Sionneau <ysionneau@kalray.eu> wrote:
> >> Forwarding also the actual patch to linux-kbuild and linux-arch
> >>
> >> -------- Forwarded Message --------
> >> Subject:        [RFC PATCH 1/1] Fix __kcrctab+* sections alignment
> >> Date:   Wed, 17 Aug 2022 18:14:38 +0200
> >> From:   Yann Sionneau <ysionneau@kalray.eu>
> >> To:     linux-kernel@vger.kernel.org
> >> CC:     Nicolas Schier <nicolas@fjasle.eu>, Masahiro Yamada
> >> <masahiroy@kernel.org>, Jules Maselbas <jmaselbas@kalray.eu>, Julian
> >> Vetter <jvetter@kalray.eu>, Yann Sionneau <ysionneau@kalray.eu>
> >>
> >>
> >>
> > What happened to the commit log?
>
> This is a forward of this thread: https://lkml.org/lkml/2022/8/17/868
>
> Either I did something wrong with my email agent or maybe the email
> containing the cover letter is taking some time to reach you?
>
> >
> >> Signed-off-by: Yann Sionneau <ysionneau@kalray.eu>
> >> ---
> >> include/linux/export-internal.h | 2 +-
> >> 1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/include/linux/export-internal.h
> >> b/include/linux/export-internal.h
> >> index c2b1d4fd5987..d86bfbd7fa6d 100644
> >> --- a/include/linux/export-internal.h
> >> +++ b/include/linux/export-internal.h
> >> @@ -12,6 +12,6 @@
> >> /* __used is needed to keep __crc_* for LTO */
> >> #define SYMBOL_CRC(sym, crc, sec) \
> >> - u32 __section("___kcrctab" sec "+" #sym) __used __crc_##sym = crc
> >> + u32 __section("___kcrctab" sec "+" #sym) __used __aligned(4)
> > __aligned(4) is the default for u32 so this should not be needed.
>
> Well, I am not completely sure about that. See my cover letter, previous
> mechanism for symbol CRC was actually enforcing the section alignment to
> 4 bytes boundary as well.
>
> Also, I'm not sure it is forbidden for an architecture/compiler
> implementation to actually enforce a stronger alignment on u32, which in
> theory would not break anything.
>
> But in this precise case it does break something since it will cause
> "gaps" in the end result vmlinux binary segment. For this to work I
> think we really want to enforce a 4 bytes alignment on the section.



Please teach me a bit more about the kvm compiler.



How does it get access to an array of u32?

u32 foo[2] = { 1, 2 };


Does the compiler insert padding between each element
so that both of &foo[0] and &foo[1] are 8-byte aligned?

Or, no padding, and the address of &foo[1] is  8 n + 4?





-- 
Best Regards
Masahiro Yamada
