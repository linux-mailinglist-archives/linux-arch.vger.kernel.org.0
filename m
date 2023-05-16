Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14EBE70526E
	for <lists+linux-arch@lfdr.de>; Tue, 16 May 2023 17:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233455AbjEPPlG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 May 2023 11:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233979AbjEPPlF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 May 2023 11:41:05 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 097FB72BD
        for <linux-arch@vger.kernel.org>; Tue, 16 May 2023 08:41:03 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id 006d021491bc7-5529fcf9d43so422354eaf.1
        for <linux-arch@vger.kernel.org>; Tue, 16 May 2023 08:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684251662; x=1686843662;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WbsMPqm3v90m7Kt6BBFrfiEYM7ABiPPbBLoB2ZG6Q3g=;
        b=Wyq1A2PGVAEvpWr68+3BoJ3z/9/0cXR2sH8ATvaFYSqdyIwD7kom5XvU0thz0wG3ge
         x4/JRJ1Uk7pED0uHYUEcwj57ULhIOtcdAyfVNH0PWG0sbPonoVtSeHKDAfrcE6FAoEii
         SJRHDMJnOG6CZbWQm3fkol3D6G4eDh2nL1j2s9EWu434VijfrPSxgJGF3RoLeY/Oo9dS
         t6lACaLXDgyGOaNzHawD449olscrGoaYX3XanxupwRMIU3dVQd2OFmQafT/uxcmJBgo9
         bS6G1wXItl4gSbZr2Y6FU9mNmspi5tRzSnlqiwTfzYonaLP4RH9qIVXa3JJndwbtQC9E
         y02g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684251662; x=1686843662;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WbsMPqm3v90m7Kt6BBFrfiEYM7ABiPPbBLoB2ZG6Q3g=;
        b=DLak0b59XAQvxPmC3Z6bTlP8eHUBYav/0fGSisrR3a46uYce2DVIT1ABKYnKzw9ctz
         At0gRUtL1X3dktmAyhO1WrLmd+Bo4Ey7z2K1OtiDercdqhvZO7yEfsGIUN1ba3fyCl8c
         N2o8/nywvzjmSTDkPW6slyjAmQ+CF7HtJnPS10h2ufbLD0NMGZwfJ4GQxjhC02DCOgTH
         krR2k1EN7FYd4gtv6gzU2ANsIeuWjASHdhxKVX+uS8Gj1JX2WgSHJAUQkh3XRp1B9J4n
         p/kLhTv542uG+9vxiIlizu24rzVjHOzGrzYlDvbRIXjRAgdsLT43Na9BYpkMkzgmZVzS
         iI8g==
X-Gm-Message-State: AC+VfDy4YEmcFCMEMU9ejteQE2fFjNHmbycaCmGRS99AG9mF+hlIF/+B
        CyFvuP7ZCVo4MAjxLLLOY0/7VfF16s5xO+p0gfI=
X-Google-Smtp-Source: ACHHUZ6dA9rQrjAkG2+kGq5fO4n9bu0GgH/FymYUcDowPI578t2MaTHa1rSqPc521PtIwWWiWDkkiTms5+fSE50XvDw=
X-Received: by 2002:a4a:301c:0:b0:551:50d8:2325 with SMTP id
 q28-20020a4a301c000000b0055150d82325mr6923294oof.3.1684251662162; Tue, 16 May
 2023 08:41:02 -0700 (PDT)
MIME-Version: 1.0
Sender: ericgloriapaul@gmail.com
Received: by 2002:a05:6358:5e0c:b0:11a:758f:2411 with HTTP; Tue, 16 May 2023
 08:41:00 -0700 (PDT)
From:   Stepan CHERNOVETSKYI <s.chernovetskyii@gmail.com>
Date:   Tue, 16 May 2023 16:41:00 +0100
X-Google-Sender-Auth: K51qsM_8nJPbmwMc7SZAvxoJIgw
Message-ID: <CAApFGfTSBwLbju1tWR1n9do3BtWN-F=jwZnNO7iDa2A=_b2_xw@mail.gmail.com>
Subject: Dear Sir/Madam,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=6.3 required=5.0 tests=ADVANCE_FEE_5_NEW,BAYES_50,
        DEAR_SOMETHING,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:c34 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [ericgloriapaul[at]gmail.com]
        *  2.0 DEAR_SOMETHING BODY: Contains 'Dear (something)'
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  1.0 ADVANCE_FEE_5_NEW Appears to be advance fee fraud (Nigerian
        *      419)
        *  2.7 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

 My beloved friend,


Please do not be embarrassed for contacting you through this medium; I
got your contact from Google people search and then decided to contact
you. My goal is to establish a viable business relationship with you
there in your country.

I am Stepan Leonid CHERNOVETSKYI, from Kyiv (Ukraine); I was a
businessman, Investor and Founder of Chernovetskyi Investment Group
(CIG) in Kyiv before Russia=E2=80=99s Invasion of my country. My business h=
as
been destroyed by the Russian military troops and there are no
meaningful economic activities going on in my country.

I am looking for your help and assistance to buy properties and other
investment projects, I consider it necessary to diversify my
investment project in your country, due to the invasion of Russia to
my country, Ukraine and to safeguard the future of my family.

Please, I would like to discuss with you the possibility of how we can
work together as business partners and invest in your country through
your assistance, if you can help me.

Please, if you are interested in partnering with me, please respond
urgently for more information.

Yours Sincerely,
Stepan Leonid CHERNOVETSKYI ,
CEO - Chernovetskyi Investment Group (CIG)
