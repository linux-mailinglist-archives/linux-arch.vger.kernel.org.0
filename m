Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE463547EDE
	for <lists+linux-arch@lfdr.de>; Mon, 13 Jun 2022 07:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbiFMFUK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 13 Jun 2022 01:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231356AbiFMFUF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 13 Jun 2022 01:20:05 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A313289A1
        for <linux-arch@vger.kernel.org>; Sun, 12 Jun 2022 22:20:04 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id m16-20020a7bca50000000b0039c8a224c95so1524543wml.2
        for <linux-arch@vger.kernel.org>; Sun, 12 Jun 2022 22:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=xOlbbk1/G8n1dzc8QggrGYyBR2sY4vXwnCTNQVuJzYg=;
        b=jA5J1OpKagA/GhRUUDRNS4eJM2MWqcHp47zx3ijAPWt99NRjdfO2DryP6OP9A8A/ED
         HmaEsXvyXJfccSny9v1TrXbkk7vhpkJxhqrT0J+yxlDDmDdyc/hdksnVWMpSiYrjIxOU
         /ye33SLkEwTN061D/ecdZIetCXg9rJ002XkAWt06MQyGwVZeLBSSHK7hKVBCu+x5wb8V
         X6BT+Xny9pF36U9/YukZd2rSyVrEx42Wav/KxACs0xrdIaOdbFYy9xt7S3BEHulM+kN9
         eACrTcKXKJ6n1IabysOxACRu+s3y+b+ya1EK3wbOOgh5q8v/HGoxoTcwf1aAKaqMEt1H
         hCZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=xOlbbk1/G8n1dzc8QggrGYyBR2sY4vXwnCTNQVuJzYg=;
        b=MuYWRKtG5mEHwQsq6aojqoZI1hetbk1ngrcGUn2iQRsbs/P+lkA5TKORbh5Lm0+T9N
         41KJes6RgEYQhftJn4gauwieyIX18ixQi6410/6VEnUpvh1OS9SshF3RdF06UQWR3GkF
         Zau33Mh0O85Xqud3LRjgcLvvddqzd2j7xK764PyPozSyvd5NG4ZtQ+Vr1GuQ/K68BSu1
         3xY5R3i+X/qNLjlrCZQPBTQYtUSh2IWP1E9waBunDgzFe2KNOAdll3Hg0lnRlGrniLIb
         PexNWQv1hFW7l8bKkCujOBng2uXh9ONZCtNsqF7rAXmFovacVIuQWb+80ITMvxlov4TY
         hPrQ==
X-Gm-Message-State: AOAM533tmpHdRfC/pPB139NpDBiHDD8Rpj+3MexhfPB52dRyL2yGgO9M
        o7/qkxTkhDMJ51xdKMvXwKjXsY86+FwS3xQUWwk=
X-Google-Smtp-Source: ABdhPJwpJblIrLXQflufz1JEUvXUCrB0CYXpX0D33w/I0lgmYLZikUBJu4h+2AUB+kGxaFl40nbLunbO4ItY4AfIroY=
X-Received: by 2002:a1c:283:0:b0:39c:975d:67a with SMTP id 125-20020a1c0283000000b0039c975d067amr1396854wmc.18.1655097602640;
 Sun, 12 Jun 2022 22:20:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:d1ea:0:0:0:0:0 with HTTP; Sun, 12 Jun 2022 22:20:01
 -0700 (PDT)
Reply-To: wwwheadofficet@gmail.com
From:   "wwwheadofficet@gmail.com" <moneygrambanktransf@gmail.com>
Date:   Mon, 13 Jun 2022 05:20:01 +0000
Message-ID: <CAEDS9iyNbYgk1z3aH5YCTHSaBu2yYgmcHgX_nAAzZrJ7LmAjvQ@mail.gmail.com>
Subject: R
To:     moneygrambanktransf@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=3.3 required=5.0 tests=BAYES_05,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FROM_2_EMAILS_SHORT,NAME_EMAIL_DIFF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

--=20
Szia

T=C3=A1j=C3=A9koztatjuk, hogy megkaptuk az IMF-t=C5=91l az =C3=96n r=C3=A9s=
z=C3=A9re t=C3=B6rt=C3=A9n=C5=91
biztons=C3=A1gi =C3=A1tutal=C3=A1sra sz=C3=A1nt =C3=B6sszeg=C3=A9t, mert az=
 =C3=96n e-mail c=C3=ADme
megtal=C3=A1lhat=C3=B3 a csal=C3=A1s =C3=A1ldozatainak list=C3=A1j=C3=A1n. =
sz=C3=ADveskedjen v=C3=A1laszolni a
tov=C3=A1bbi r=C3=A9szletek=C3=A9rt.

V=C3=A1rom, hogy hamarosan halljunk

Szeretettel.
Tony Albert
Iroda igazgat=C3=B3ja
