Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB26973D385
	for <lists+linux-arch@lfdr.de>; Sun, 25 Jun 2023 22:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbjFYUGJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 25 Jun 2023 16:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjFYUGI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 25 Jun 2023 16:06:08 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C9AB8
        for <linux-arch@vger.kernel.org>; Sun, 25 Jun 2023 13:06:02 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6687446eaccso2437101b3a.3
        for <linux-arch@vger.kernel.org>; Sun, 25 Jun 2023 13:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20221208.gappssmtp.com; s=20221208; t=1687723561; x=1690315561;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6SoUflbTM/FpgEV6FO9AKFH9tH6vucslhbHlIS2yfeM=;
        b=HEBsbjGGx1kZCdDVvczFGgbEwibjlGcvAqUzs3KSeYavcoe0OQew/dJPuWJ2fDU8aO
         LwX7avZVqftVOAzbT3yiuaZXEQxShYdl7QdLan6mHMYEKOXGTW54kY4333QO2wpM6yzn
         P42LegXOak5nhVcXYqUPTiDv4fscpl/u5jfHgkV7c1ujC1xrRbtzXArl/xAeQ3/m7x0Y
         32WMkMRZP5G0ubGoVNeS9mXC0J1h1dnB20GWh474Yz4RdqPFmKVLuojNVKijCQ3rOuCJ
         6Aqnff7fvv0b8omHT3Lc47IOnbX3bqUeL7EGNiTWfUHJJ0TgShiTIpRi6Ng/dtp1LJGU
         eFIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687723561; x=1690315561;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6SoUflbTM/FpgEV6FO9AKFH9tH6vucslhbHlIS2yfeM=;
        b=PgbzA2Qib1vqRn2wqGo1o0k9Xy17FDj3Oo0OO6jZ8X8cwvbAUs/y9H29LvoP45qt9a
         KsAph5aUGlIEmJKuLp4awUoK+FblAOoXaEZt9S58lwUU6viPWba4kMbKKGCyVdv2rEXp
         VoeWlWPfq2YBg8y24qrEgPUoh6/3OgkqMtUO1aql95rLpsJm8zX1B3aC41ltvRHZsDmX
         8Pf+KfSwLDzRvMR+H3HOZZ6Cg5l4xaixpprqjBU7MUUYpsFAsmw+OoKMSjYlzNKaKW5r
         5QtUbSm6tlMC7ZASnk/LNp+wd74sz5SIu29ayYVxaUQAG8DiHX3LvqQBetCnvkG0o4t8
         b4Ng==
X-Gm-Message-State: AC+VfDzWRB9DQMn/IYDBAHhHzwM79aJ4MbD8HZqzW57Z7HKnxARGWDan
        Aq0VMQ5uRqjR070hbGgleoIVb8vM8p3688ydhXg=
X-Google-Smtp-Source: ACHHUZ6YpB0pPhcNFt6HBv132zCVyQgfSQKH6WBiygV4lwtb4ywoYCMuSo9j3IXzVhyHYdf/1av8EQ==
X-Received: by 2002:a05:6a20:918d:b0:126:f0d8:445e with SMTP id v13-20020a056a20918d00b00126f0d8445emr2746471pzd.32.1687723561054;
        Sun, 25 Jun 2023 13:06:01 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id p2-20020a62ab02000000b0067777e960d9sm456469pff.155.2023.06.25.13.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jun 2023 13:05:59 -0700 (PDT)
Date:   Sun, 25 Jun 2023 13:05:59 -0700 (PDT)
X-Google-Original-Date: Sun, 25 Jun 2023 13:05:16 PDT (-0700)
Subject:     Re: [PATCH v2 0/4] riscv: enable HAVE_LD_DEAD_CODE_DATA_ELIMINATION
In-Reply-To: <20230625-radish-comic-b0861fb96023@spud>
CC:     jszhang@kernel.org, ndesaulniers@google.com, bjorn@kernel.org,
        llvm@lists.linux.dev, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, Arnd Bergmann <arnd@arndb.de>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Conor Dooley <conor@kernel.org>
Message-ID: <mhng-c2d55859-cf3b-48ac-bf38-9aa1344fc93c@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, 25 Jun 2023 05:43:13 PDT (-0700), Conor Dooley wrote:
> On Sun, Jun 25, 2023 at 08:24:56PM +0800, Jisheng Zhang wrote:
>> On Fri, Jun 23, 2023 at 10:17:54AM -0700, Nick Desaulniers wrote:
>> > On Thu, Jun 22, 2023 at 11:18:03PM +0000, Nathan Chancellor wrote:
>> > > If you wanted to restrict it to just LD_IS_BFD in arch/riscv/Kconfig,
>> > > that would be fine with me too.
>> > > 
>> > >   select HAVE_LD_DEAD_CODE_DATA_ELIMINATION if LD_IS_BFD
>> > 
>> > Hi Jisheng, would you mind sending a v3 with the attached patch applied
>> > on top / at the end of your series?
>> 
>> Hi Nick, Nathan, Palmer,
>> 
>> I saw the series has been applied to riscv-next, so I'm not sure which
>> solution would it be, Palmer to apply Nick's patch to riscv-next or
>> I to send out v3, any suggestion is appreciated.
>
> I don't see what you are seeing w/ riscv/for-next. HEAD is currently at
> 4681dacadeef ("riscv: replace deprecated scall with ecall") and there
> are no patches from your series in the branch:
> https://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git/log/?h=for-next

It's been in and out of staging a few times as we tracked down the 
performance regression, but it shouldn't have ever made it to linux-next 
for real.

I'm fine just picking up the patch to disable DCE, I've got a few other 
(hopefully small) things to work through first though.

> Cheers,
> Conor.
>
>> > > Nick said he would work on a report for the LLVM side, so as long as
>> > > this issue is handled in some way to avoid regressing LLD builds until
>> > > it is resolved, I don't think there is anything else for the kernel to
>> > > do. We like to have breadcrumbs via issue links, not sure if the report
>> > > will be internal to Google or on LLVM's issue tracker though;
>> > > regardless, we will have to touch this block to add a version check
>> > > later, at which point we can add a link to the fix in LLD.
>> > 
>> > https://github.com/ClangBuiltLinux/linux/issues/1881
>> 
>> > From 3e5e010958ee41b9fb408cfade8fb017c2fe7169 Mon Sep 17 00:00:00 2001
>> > From: Nick Desaulniers <ndesaulniers@google.com>
>> > Date: Fri, 23 Jun 2023 10:06:17 -0700
>> > Subject: [PATCH] riscv: disable HAVE_LD_DEAD_CODE_DATA_ELIMINATION for LLD
>> > 
>> > Linking allyesconfig with ld.lld-17 with CONFIG_DEAD_CODE_ELIMINATION=y
>> > takes hours.  Assuming this is a performance regression that can be
>> > fixed, tentatively disable this for now so that allyesconfig builds
>> > don't start timing out.  If and when there's a fix to ld.lld, this can
>> > be converted to a version check instead so that users of older but still
>> > supported versions of ld.lld don't hurt themselves by enabling
>> > CONFIG_LD_DEAD_CODE_DATA_ELIMINATION=y.
>> > 
>> > Link: https://github.com/ClangBuiltLinux/linux/issues/1881
>> > Reported-by: Palmer Dabbelt <palmer@dabbelt.com>
>> > Suggested-by: Nathan Chancellor <nathan@kernel.org>
>> > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
>> > ---
>> > Hi Jisheng, would you mind sending a v3 with this patch on top/at the
>> > end of your patch series?
>> > 
>> >  arch/riscv/Kconfig | 3 ++-
>> >  1 file changed, 2 insertions(+), 1 deletion(-)
>> > 
>> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>> > index 8effe5bb7788..0573991e9b78 100644
>> > --- a/arch/riscv/Kconfig
>> > +++ b/arch/riscv/Kconfig
>> > @@ -116,7 +116,8 @@ config RISCV
>> >  	select HAVE_KPROBES if !XIP_KERNEL
>> >  	select HAVE_KPROBES_ON_FTRACE if !XIP_KERNEL
>> >  	select HAVE_KRETPROBES if !XIP_KERNEL
>> > -	select HAVE_LD_DEAD_CODE_DATA_ELIMINATION
>> > +	# https://github.com/ClangBuiltLinux/linux/issues/1881
>> > +	select HAVE_LD_DEAD_CODE_DATA_ELIMINATION if !LD_IS_LLD
>> >  	select HAVE_MOVE_PMD
>> >  	select HAVE_MOVE_PUD
>> >  	select HAVE_PCI
>> > -- 
>> > 2.41.0.162.gfafddb0af9-goog
>> > 
>> 
