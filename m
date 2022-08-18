Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 938D05986CB
	for <lists+linux-arch@lfdr.de>; Thu, 18 Aug 2022 17:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344006AbiHRPDb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 18 Aug 2022 11:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344011AbiHRPD1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 18 Aug 2022 11:03:27 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2401D6553
        for <linux-arch@vger.kernel.org>; Thu, 18 Aug 2022 08:03:24 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-334dc616f86so48341717b3.8
        for <linux-arch@vger.kernel.org>; Thu, 18 Aug 2022 08:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc;
        bh=NeMjJDNZNfq9bVPkQ3ZaXZJSX16cgQTbKO9CgeGMDx8=;
        b=gfVtI8uQcLl5ykXBfJcgKSUpkF+8DmTkvaIt1Jov5L39rXIiUFZvaJeEEtDyV0APas
         4xVTPLsIzqBu+hTb+IWXg3C4YW/Yu3mJbpzJImOC+qRE7aqPkYPY9nrpyP2x1I2OkNnk
         DCR3FliIa+ZlopM5NOdFBjyd7Wv1Latl7MJRvWxtYy2FSmvSYqQxLGLcno5EVZaN88SK
         He6mnYXl5nsQQIIn322Pza9HDyq3t2TF8bRXnRZU5QkUHT+OFN9WvPZPU8icK0XPRQ+E
         53zoLq28DNOCX8Hd7ZSIKrOAGtmafWUQqbrGFWj7rhVAw7uZOutUlDzJyeLuDvU0lske
         0lOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc;
        bh=NeMjJDNZNfq9bVPkQ3ZaXZJSX16cgQTbKO9CgeGMDx8=;
        b=Ub98RIMPH4/FjsfNbN7iz61SEzhbbuMNOjwtHjJK4PH4eMCoHnkbIYli1B7kqn6eJ8
         iNaP5i98+UbmplKRYtZ9MscXGFOegZSfqE2QC9vJUhvaSgqaUDLj8jEDM5dneO6Wh8Nr
         Chql95S299u2/gcxdPPVFb5t4RKtLs+xsABUY/5Vc4ZEP/ZfgrHPmCMOgRWTyxPM4mSQ
         m73cEYue4zgkzWQU8nhE0ogvXdWjDr7AEHsiewdbqW9cgewns4k0T3XdKbDdt/ewPK2P
         w94fvAq+mNLChTP47ztyolkeBGLS7QM9DAg0B0Ttu2Zrv7NROK6rOI7hntD1aLjrrzHr
         l5JQ==
X-Gm-Message-State: ACgBeo2fTuy3kWCzs8j+Tmn3h9cRLrp4RNwu+737JUcTEeJNEDDB6Z0j
        9WbYHd5WAbsLNdYlX6GzmVk46VTmf2WNRh8Iqes=
X-Google-Smtp-Source: AA6agR7GDSlQ24fp+MC1+PcJfmL+7SaHjn1po3L2kW+BJX1mRlM9fSXBJAnLObbEwwcA9pYc02oE/sVHeG3NS2QutMI=
X-Received: by 2002:a25:9b88:0:b0:66d:b166:a430 with SMTP id
 v8-20020a259b88000000b0066db166a430mr3322791ybo.80.1660835003111; Thu, 18 Aug
 2022 08:03:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7000:c198:0:0:0:0 with HTTP; Thu, 18 Aug 2022 08:03:22
 -0700 (PDT)
Reply-To: golsonfinancial@gmail.com
From:   OLSON FINANCIAL GROUP <mainasarajafarumrd@gmail.com>
Date:   Thu, 18 Aug 2022 08:03:22 -0700
Message-ID: <CAGDwTEw=K7Pai4RzkKSv5WYqkyet+LqCtTjSrDfV-Y5BPPBuSg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

--=20
Hallo guten Tag,
Ben=C3=B6tigen Sie dringend einen Kredit f=C3=BCr den Hauskauf? oder ben=C3=
=B6tigen
Sie ein Gesch=C3=A4fts- oder Privatdarlehen, um zu investieren? ein neues
Gesch=C3=A4ft er=C3=B6ffnen, Rechnungen bezahlen? Und Sie zahlen uns
Installationen zur=C3=BCck? Wir sind ein zertifiziertes Finanzunternehmen.
Wir bieten Privatpersonen und Unternehmen Kredite an. Zu einem sehr
niedrigen Zinssatz von 2%. F=C3=BCr weitere Informationen
mailen Sie uns an: golsonfinancial@gmail.com....
