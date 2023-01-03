Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B54A965BCD7
	for <lists+linux-arch@lfdr.de>; Tue,  3 Jan 2023 10:12:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233070AbjACJMT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 3 Jan 2023 04:12:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232995AbjACJML (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 3 Jan 2023 04:12:11 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C486464
        for <linux-arch@vger.kernel.org>; Tue,  3 Jan 2023 01:12:09 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id e10so5805869pgc.9
        for <linux-arch@vger.kernel.org>; Tue, 03 Jan 2023 01:12:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FJYPIPbgrLqbUEgstYOfOz1W7/cTonzcVLLdfFZxjek=;
        b=CvFV8seau2uPVDjiBgN/zt2A6I4FQ7mg685mg3+lO+0anMayfNrmHIEYZyd2kUYCPs
         ilNkZUwdQJNcXvDyVDQZE9t2rNfR3UiAm+/H9Y1pk/X6oCTDXZYhjojRNiCkd/1/mGkQ
         jYuXukrZCdfXUsbGu1TaOONhad/9bTCOKKeu40FSsD+3WdF95suPOTKXrbcspG56GIsk
         YQV8jzA3NUmiereQmupLdKgWuT9//yHyHqvqUZ+eHVoyZzDdd/ncCLNnAIZj5p8CCevC
         mt6EgyyLJvet+uf79CxeQPmE4o/nFUPdUmThWtczNviX+5NXdRiwja5iq5pBKg8w104S
         5msA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FJYPIPbgrLqbUEgstYOfOz1W7/cTonzcVLLdfFZxjek=;
        b=n4zLizEakS6xST8ZCzimJF3q+ts6beAGiEQwq42OPYKOhX/8llfuYeaYLYLgieCEdk
         CxdUO9iesAo/asb/0FUkxdZmfJYZtzc3zYPTT+psbxKq8nncgLgFlua3BZVIdFNqPrdu
         bPDKYZoAqtZeIE13R1IWF9/y/2ry22dCyTfAif0XtgsHT5wrJCJJTQvPSetloUS2jg9d
         GVLjAJoOgGXRu/L2VMVJZ0SaYqBL89yjkySO3DPwR0yof2V4xHvwOJSlV91aXB9a+OqK
         octjK8Bjgz+wI1hgPc1kTZ+a4E2jaWuPexfEg0vEwqsSZ7KJx2RpP5BU92xHHz4ghibE
         W/pg==
X-Gm-Message-State: AFqh2kqLDEigr7g3G+OZHT/PpZ26GZG5wbxCQYOWY7TMGYOnS76xu5uf
        QSCiXMoGVWGCMeW28vbBV3Xvtd8MYhcCeIrdEZ8=
X-Google-Smtp-Source: AMrXdXteGwmblSMi0a5emkFxgJyrwaQgq7zMYVmMFAKwtVBxM0Px0IlkvuRpXb2ivhjQYzJnSYtEffGJQh25xpDIY00=
X-Received: by 2002:a65:6946:0:b0:478:20ca:fe8c with SMTP id
 w6-20020a656946000000b0047820cafe8cmr1270771pgq.223.1672737129251; Tue, 03
 Jan 2023 01:12:09 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ac4:9927:0:b0:58c:e731:e5e3 with HTTP; Tue, 3 Jan 2023
 01:12:08 -0800 (PST)
Reply-To: wongshiule@gmail.com
From:   Wong Shiu <dm095494@gmail.com>
Date:   Tue, 3 Jan 2023 11:12:08 +0200
Message-ID: <CABzOTgaY9q2Z3QDCA9G=NYVEJNQUgA+fM--06sZBZh3dca9mHg@mail.gmail.com>
Subject: Guten Tag
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=6.8 required=5.0 tests=BAYES_95,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:535 listed in]
        [list.dnswl.org]
        *  3.0 BAYES_95 BODY: Bayes spam probability is 95 to 99%
        *      [score: 0.9897]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [dm095494[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [dm095494[at]gmail.com]
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  2.7 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

--=20
Guten Tag

Ich habe Ihre E-Mail-Adresse in der Google-Datenbank gefunden,

Ist Ihre E-Mail-Adresse noch g=C3=BCltig? Ich habe einen guten
Gesch=C3=A4ftsvorschlag f=C3=BCr Sie,

Bei Interesse kontaktieren Sie mich bitte f=C3=BCr weitere Informationen
unter: wongshiule@gmail.com

Wong Shiu
