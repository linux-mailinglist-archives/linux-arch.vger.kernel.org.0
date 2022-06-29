Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4D8655FA1E
	for <lists+linux-arch@lfdr.de>; Wed, 29 Jun 2022 10:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbiF2IFh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 29 Jun 2022 04:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232674AbiF2IFe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 29 Jun 2022 04:05:34 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B99F3BA40
        for <linux-arch@vger.kernel.org>; Wed, 29 Jun 2022 01:05:32 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id i17so9746434ils.12
        for <linux-arch@vger.kernel.org>; Wed, 29 Jun 2022 01:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=6HUexq4BhGbBTV432WsVIcreK/IjO5ohg/cHk0ZOg/s=;
        b=K/TIInwdtIkpGJmiiqcr1dEYj1kccATXGHDfDZAPJTyvOwN3rPgG2mDDwK/LwBTbic
         F1WpauLJNVLPd80YDgGxtXtrB246ONuNH7gStKL9kYMUHJ9OZezLsoqL9e1ICEGFklM/
         sxmBbMly+sUEXnpYL/idkXgMoVC2L2arxUWfTOHXfdeJGZV8SMu6m6gc0sXnGOIDAM+k
         OBrzPH4UCm/Uv63O2E/TrQ3u5dmTQFJaZ3/KobN8iwf+NjBwXZoRSu2BkObVM9iFXgVC
         VQaRd6YfQD4mZuCxPsByAhYKq4bOSLD5qH3X+NndyhslAwVomHrzPBK8O9GbmYNy1QlR
         pCvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=6HUexq4BhGbBTV432WsVIcreK/IjO5ohg/cHk0ZOg/s=;
        b=SMSpqhIQfD9PUJBTRXzvacNuXym70LeeUO32e6SA2ID+96/nNHYA8Bt8qJtuXmDeox
         JJngD+XviAlxOrOESuTL6OL2Az/HDsFOVCxafoYH7jZM1pWClgNqSPFHHkkCQFg7JF5G
         UiDt/r4KHBUI0yG1kbf6tglRhjemkla/KmXQUpjqGONqsYUAhIm4tuDVGKoTPwv5IeHP
         U58k7G+5qRQjB4wH8IK7uRmJ744fXyFs9sYG6iB++pUs0yB9+9nD0WC9TPsA7ZRnVXDy
         tV/BcRpmGpHk2AREIHV2KKVXWz41t78Ux62fmoCpmfkxOwupscZ9mYGnvhqy2tpYNxv+
         Gmyg==
X-Gm-Message-State: AJIora+Ez0Df3ao1LlvNZ0+blbr94vpt9CfaVX+AdSkc4/iYe8ZQlqqN
        3k3um0aTGnzafMzP6LAf07dWn+qJPWWQKEeBkOM=
X-Google-Smtp-Source: AGRyM1sJgmGhfLf7wTfswAT2SvH3i4tw4vGVlP154WLrJQRrIfyXh5GcQ/W9N6qShUyZpyah/32e2ERafL+kES1UTGk=
X-Received: by 2002:a05:6e02:1d19:b0:2d9:1705:892b with SMTP id
 i25-20020a056e021d1900b002d91705892bmr1181011ila.61.1656489931961; Wed, 29
 Jun 2022 01:05:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6622:3422:0:0:0:0 with HTTP; Wed, 29 Jun 2022 01:05:31
 -0700 (PDT)
Reply-To: martinwaghorn1k@gmail.com
From:   Financial Conduct Authority <misscarolinalennon@gmail.com>
Date:   Wed, 29 Jun 2022 09:05:31 +0100
Message-ID: <CAJx=MB0uU3NdbyKfZGL=fTNm7KfsZf5We6LD1joQ8K7GqkyNqQ@mail.gmail.com>
Subject: IMPORTANT NOTICE!!
To:     misscarolinalennon@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.3 required=5.0 tests=BAYES_80,DEAR_BENEFICIARY,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        SUBJ_ALL_CAPS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

                         APPROVED FUNDS / GUARANTEE FOR PAYMENT
Attn: Fund Beneficiary,
This is to inform you that our office has been mandated by the World
Bank Group in affiliation with the International Monetary fund and
United Nations World Body on financial and allied matters to release
funds to you. kindly acknowledge this message for further information
.
Yours in Service,
Martins Waghorn J.
