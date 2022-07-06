Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF56568F45
	for <lists+linux-arch@lfdr.de>; Wed,  6 Jul 2022 18:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbiGFQfK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 6 Jul 2022 12:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233321AbiGFQfK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 6 Jul 2022 12:35:10 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14304167D2
        for <linux-arch@vger.kernel.org>; Wed,  6 Jul 2022 09:35:08 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-f2a4c51c45so22058575fac.9
        for <linux-arch@vger.kernel.org>; Wed, 06 Jul 2022 09:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Uk0kx353H+gGEfDDNFmV1k9XciWZTV5g6S3ovbgNaYc=;
        b=a/m5Zbtjs+w7Cs5ZKWUYr4/GQk2GhqNGn0Pqt3OuS99B963ld9rkt+CC1x6LbkdZje
         ORX+dm7fkYlCVd/i462jSV2mAfVSir2EZtFOvx8CHwOWj5EawDek/6nVv+EM1NKX7pip
         ciLDMlmFbltENMEnUpzie1qsJ+piMrq3XzwdHkboQUT1cFlY8moCX2fmb8yEI8y+agYq
         93UI+Epy430sXZWaVOLRdi6qm0xeK1nNBIVhnMAxjCYWgG75pcNYXh00yexXL31/xVA2
         YsagJpndX7EgRaQeHzmpLqG38+nv8n3WJt6CQnH0kcJRippmW7VRUE0q/UVq9NkgZ6Y5
         sWwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=Uk0kx353H+gGEfDDNFmV1k9XciWZTV5g6S3ovbgNaYc=;
        b=I3qBigR9XifPdzkRnsjPTD1fBErAChZjEIMhN7llj2E4bSsiXKO0/8k7fYLarX3aDn
         P8Fh+f//CRsNxjUvLahpVFxOMz6h+yCNcONh99U0w89wloQ4syB8lNAoFpRb5VWMUVHG
         HED4qqpOxoAnYy0eF+8FhkEe/Ks4j04/mXn92hju7U4TibI0IWctG4+kla0CreBS+2t6
         duF7jYf+IU5oLvd40MJDm19OJxYCJ6e/060iwduEwDqOX1YC63d/PYJ3VJOx5VbixyN+
         aGhjP4+nP7vwBMLOwyS5Xmc2rVNpKkp0GBVaaGs2AgcTd1XpmyheMuhgEkCldTrIyo86
         f1Ow==
X-Gm-Message-State: AJIora8T06WkHHRg2XJVvcLZb0ibuHAX1yz7f5z2gGDjAiaLxTeA5lMM
        Ml7CqIfiduHezr4a4taW0XYAsa5gRCOpqB1kugE=
X-Google-Smtp-Source: AGRyM1smILV06tNR6HFjr0Gd3LM9rg3teKaB/wATIfIfIRzns6yjcW7rYXqi8RWqQumIvfuyBiVgj5ZsSKT+H6EfY2U=
X-Received: by 2002:a05:6870:7022:b0:10b:f0ea:d441 with SMTP id
 u34-20020a056870702200b0010bf0ead441mr12117271oae.39.1657125307508; Wed, 06
 Jul 2022 09:35:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:4545:0:0:0:0:0 with HTTP; Wed, 6 Jul 2022 09:35:07 -0700 (PDT)
Reply-To: sgtkaylla202@gmail.com
From:   Kayla Manthey <avrielharry73@gmail.com>
Date:   Wed, 6 Jul 2022 16:35:07 +0000
Message-ID: <CAFSKFDZeauyj6MnQh+7D821dodoH9VUedYW1OZPWEjihD6mNdw@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=4.2 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

LS0gDQrQl9C00YDQsNCy0L4g0LTRgNCw0LPQsA0K0JLQtSDQvNC+0LvQsNC8LCDQtNCw0LvQuCDR
mNCwINC00L7QsdC40LLRgtC1INC80L7RmNCw0YLQsCDQv9GA0LXRgtGF0L7QtNC90LAg0L/QvtGA
0LDQutCwLCDQstC4INCx0LvQsNCz0L7QtNCw0YDQsNC8Lg0K
