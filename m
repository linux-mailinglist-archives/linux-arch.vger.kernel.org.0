Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9DB6D3281
	for <lists+linux-arch@lfdr.de>; Sat,  1 Apr 2023 18:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbjDAQIT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 1 Apr 2023 12:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjDAQIS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 1 Apr 2023 12:08:18 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B29D1C1E2
        for <linux-arch@vger.kernel.org>; Sat,  1 Apr 2023 09:08:17 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id h14so15150574pgj.7
        for <linux-arch@vger.kernel.org>; Sat, 01 Apr 2023 09:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680365297;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ps43Ql5Tjnd+rS8BdUE8H1PpwwGazEWm6mc1DzBYYUo=;
        b=Kwr3W/FEdHbtcKYK/anRPpxLbcUskZmIJpZtKFYDVp15aeO1JD1JHgj2OOcmAkEv8Q
         20vUegpCoW3TVvJmEUSUh5/zRsUKdaFq2SOECTocD1KnyrpiGxfF89vSxqyawFv36896
         5hkSarMgRB1c4cuHiM0KkfsoVL3h8Sva301QkgjWTtRaTjcCKAnfFaJoxwDv3oMWkl9Y
         4i6XjnHWoP5/q2sPk9P9XwKE64z3TqS2LfXc0pdAIQ3MtnPO0NEufsj9fd4S3y0tjtcq
         h9IJMyw906/6vzXFR6kRLnh1j2nN8bjiVUVfjrOnaK3uyeX+pAYf2KBPhA13PhAnud52
         S0CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680365297;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ps43Ql5Tjnd+rS8BdUE8H1PpwwGazEWm6mc1DzBYYUo=;
        b=QjDQxA1V++G+RhgvsEpQO3IVNYVTvXVRGS1aYmIOOASHAXQxcc+G4vTdhYcjWpwzQT
         gGs9E2nMiglvwh6lC07ebWMsn2Wgn1NnGRBWAOX5LsG5foiQDl1JiR1ySkTm2o6wWAg8
         j20E8KCqP3NXaVnDN6Ajpc8gg+sUDBrJcv0P60d7V54E9XtquqtzZUbnuJ8INfqrqaU+
         DeRI/PNh33asBqnwriC/P7OR75GDQ1RU3wAULp4v7R9x50kSBoWfrTwMolGjI2zuxMay
         PEsWE7GDF6TGMMXpLUr19DZu18ULOC55YhL0QI46YLEC3zxsZMVd2M+mrX/lO/MJ4elv
         zsew==
X-Gm-Message-State: AAQBX9dyTr326yW0/kaegd845Q6SNV5z7iVfItBsGz35ZIDe4DXwrqrV
        ZdoLPFPw68vwInoQNEQ57ngW0F6SYUP/gTMi/xA=
X-Google-Smtp-Source: AKy350YOoWi7M6sALuAFW27BROSoarkoGH8ZMNg6QU4Ez3Eeg94oNiOQTEdLng8iMv2/RjlpKxS6P1Fk41cj3Bt1gyU=
X-Received: by 2002:a63:4e08:0:b0:4fb:1f2a:e6c6 with SMTP id
 c8-20020a634e08000000b004fb1f2ae6c6mr8326464pgb.2.1680365297133; Sat, 01 Apr
 2023 09:08:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a10:8c92:b0:474:c743:9f91 with HTTP; Sat, 1 Apr 2023
 09:08:16 -0700 (PDT)
Reply-To: fiona.hill.2023@outlook.com
From:   Fiona Hill <leea4982@gmail.com>
Date:   Sat, 1 Apr 2023 09:08:16 -0700
Message-ID: <CADa=nC3PFDgC2QHt9T856DzEvvSWnfVaeKq+_KchNN37RXnhvQ@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

-- 
Hello did you receive my message?
