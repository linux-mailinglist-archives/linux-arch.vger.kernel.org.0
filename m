Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7141D7DF8B8
	for <lists+linux-arch@lfdr.de>; Thu,  2 Nov 2023 18:29:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbjKBR3M (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Nov 2023 13:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbjKBR3L (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Nov 2023 13:29:11 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A302182
        for <linux-arch@vger.kernel.org>; Thu,  2 Nov 2023 10:29:05 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-5437269a661so4531496a12.0
        for <linux-arch@vger.kernel.org>; Thu, 02 Nov 2023 10:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1698946143; x=1699550943; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uyMmGK3pqJfPbS0jfDAKY0ZEUhFBNW+33Pb+xOdwSj8=;
        b=cCk5Y1tD8TygWnzE6HR3Jfe6pE2vzR1zf9syWxGcNFJLdHi9yxdlDSKNA//Gi9n4G9
         hGFHyBX+0WDz5L/KHn2hO/9IL6uVEy4Dckma24oEPONFsxcJ71w9+zDHMmVlQ8FRhgJw
         ESkw5Gyaj7oXlqSlozj6kB68H0d8uobFZ28a0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698946143; x=1699550943;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uyMmGK3pqJfPbS0jfDAKY0ZEUhFBNW+33Pb+xOdwSj8=;
        b=GFrmmwKLYbhgDzDKq9NYQ7G/n3ms+T7tC+A54TYVMO77AcPEcebTr+2tKUktPmz5Ev
         beAo/x0eh2arZBOtSafD2y2rQbEpXCtr2wIVrn2eYitHUkdrjLAk7J6bmu5Cow6SejaU
         L3g2ohOnkeM9p/12zJ5mV9u+51tzZ++2jToRj+r3/Q0VRBRiSq37k0YRHCo9F6ySBiN+
         wXtUHeYwGiD4+q+JdAkQSDsN+mQnfBk3azqK8ErXSJBrbUUYiE7q0NvrV+NFUwwA53G/
         bXCVzOaRQUx/5TxjTpOYtzrMYmeyHoofMiJNpVgqrEqhZLRZLRicnIjoZsr1SuJvKHVe
         huFg==
X-Gm-Message-State: AOJu0YybuPRI24wKo6xTdVyP9dxsIRw446XrXskej9QqWV0VV66ddG8U
        RTo+F4gQCuiWO6ZqyVVDtFo3wv6l3/EPiob/Nm44wf2p
X-Google-Smtp-Source: AGHT+IEm8oim1G2lI8pPXAckdsm009kkjqvxbNlBPHMlHYyuRl6+D63mXJqdbqOaBOVPFStpJ3NF1w==
X-Received: by 2002:a17:907:2da5:b0:9c3:97d7:2c67 with SMTP id gt37-20020a1709072da500b009c397d72c67mr443753ejc.25.1698946143568;
        Thu, 02 Nov 2023 10:29:03 -0700 (PDT)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id gr7-20020a170906e2c700b0099bcf1c07c6sm1391115ejb.138.2023.11.02.10.29.02
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Nov 2023 10:29:03 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-9becde9ea7bso463637366b.0
        for <linux-arch@vger.kernel.org>; Thu, 02 Nov 2023 10:29:02 -0700 (PDT)
X-Received: by 2002:a17:907:1c87:b0:9a9:f0e6:904e with SMTP id
 nb7-20020a1709071c8700b009a9f0e6904emr470853ejc.16.1698946142622; Thu, 02 Nov
 2023 10:29:02 -0700 (PDT)
MIME-Version: 1.0
References: <340fc037-c18f-417f-8aaa-9cf88c9052f4@app.fastmail.com> <8ff191a0-41fa-4f36-86e8-3d32ff3fe75c@web.de>
In-Reply-To: <8ff191a0-41fa-4f36-86e8-3d32ff3fe75c@web.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 2 Nov 2023 07:28:45 -1000
X-Gmail-Original-Message-ID: <CAHk-=whFLZ67ffzt1juryCYcYz6eL_XjQF8WucDzwUR5H65+rA@mail.gmail.com>
Message-ID: <CAHk-=whFLZ67ffzt1juryCYcYz6eL_XjQF8WucDzwUR5H65+rA@mail.gmail.com>
Subject: Re: [GIT PULL] asm-generic updates for v6.7
To:     Frank Scheiner <frank.scheiner@web.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?B?VG9tw6HFoSBHbG96YXI=?= <tglozar@gmail.com>,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 2 Nov 2023 at 00:24, Frank Scheiner <frank.scheiner@web.de> wrote:
>
> so the ia64 removal happened despite the efforts - not only from us - to
> keep it alive in Linux. That is a - sad - fact now.

Well, I'd have personally been willing to resurrect it, but I was told
several times that other projects were basically just waiting for the
kernel support to die.

Has the itanium situation really changed?

The thing is, nobody doing new kernel code wants to deal with itanium,
so relegating it to the same situation that i386 support was ("it
still works in old kernels") doesn't seem to be a huge issue for the
people who actually want to use those machines.

That said, I'd be willing to resurrect itanium support, even though I
personally despise the architecture with a passion for being
fundamentally based on faulty design premises, and an implementation
based on politics rather than good technical design.

But only if it turns out to actually have some long-term active
interest (ie I'd compare it to the situation with m68k etc - clearly
dead architectures that we still support despite them being not
relevant - because some people care and they don't cause pain).

So I'd be willing to come back to the "can we resurrect it"
discussion, but not immediately - more along the lines of a "look,
we've been maintaining it out of tree for a year, the other
infrastructure is still alive, there is no impact on the rest of the
kernel, can we please try again"?

               Linus
