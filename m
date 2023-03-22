Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC6AE6C4FF9
	for <lists+linux-arch@lfdr.de>; Wed, 22 Mar 2023 17:05:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbjCVQE7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Mar 2023 12:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjCVQE6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Mar 2023 12:04:58 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B7B15B83
        for <linux-arch@vger.kernel.org>; Wed, 22 Mar 2023 09:04:56 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id y4so75092476edo.2
        for <linux-arch@vger.kernel.org>; Wed, 22 Mar 2023 09:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679501095;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UK4Nxu8VuNlDMW0oI9hxwlYcdkLqjNPKCstHpYnJQtw=;
        b=O49mXDn+xJ31gGYFOmJjMPeYIGf08El3dtkOGm4CcmOpU4qwsiO2qVkNMRfeYkPJ2Q
         6LHs9ltONXZn9SLVz25Rr/UeqLZIT1vA7yL3iYZjAe6QxLEMwt2xgSHQA3D9tilOwdZW
         B+Uq19wUiQ61TNd17VNtUEIwVrejw6PlbliwHfm4QZSljILxI+17W0qjDCuC6jBQ2GTX
         un/yMgLMCwo0Pi34E++cV77zjgcUo3A46xug3M/B3ytwJvAbWbvfy52cr6hXKq9MabVb
         VxTTMkODbC47T6KkuTFYmvqOReklTvi3Dq9VyRBdNU83tALHG3yHlMSrB7NOTWv0X4UD
         agQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679501095;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UK4Nxu8VuNlDMW0oI9hxwlYcdkLqjNPKCstHpYnJQtw=;
        b=LFB2dKIe6W6rvWfLh3Krbm7xydNg9hokiZHueRa8rlUKw78NuHTD7FDOX+Ohpytx8c
         QmZ0sBx6kPf4xdlvnl5WphFfhYYlOgQeYwDBoUZzzYNPcAeFQDlo/Te15JeJeY48PQHs
         DdqTJKsDr0RN7s2uDLH1sneO4j8u4J5vpTzb1PJ7VdBrPKT66a6pSnVpATC+rQaVwBXI
         hmM/AqKN/39/YL65rqv1Vm3UvetbdbdAM/rk/w0IVkh49pq5RLHNA2M5bDaoPTiuaBD/
         zCqX8r9qETDTIvdblqObBMIYt6tHI4ZSiFfGtwe5Jm1gPnCy7Tejf6JLGtaahfGwwrYy
         2qKQ==
X-Gm-Message-State: AO0yUKWOfcLUwpCUTuq6otZyDSyagKgsUTnPRnt3D7HIdzGFeyxc5eC0
        JRqCb8mjkjLoWqreUBYdrgGVuLmWirGHbHyp7s8=
X-Google-Smtp-Source: AK7set8Dx9F2k09citaitDJik8GuiTbXZDh1akAFKgv1KR6hNCjwbH5sRG7XF89ROuXnekqeuwR1qYRUvVWAgRTcQak=
X-Received: by 2002:a17:906:3e4b:b0:8dd:70a:3a76 with SMTP id
 t11-20020a1709063e4b00b008dd070a3a76mr3686024eji.11.1679501095056; Wed, 22
 Mar 2023 09:04:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:907:6a11:b0:933:4577:4f9d with HTTP; Wed, 22 Mar 2023
 09:04:54 -0700 (PDT)
Reply-To: fionahill.2023@outlook.com
From:   Fiona Hill <thankgod07062@gmail.com>
Date:   Wed, 22 Mar 2023 09:04:54 -0700
Message-ID: <CA+wdF_FroZOa-a3UjjVqyrxdUHZWxGDh5gLWTbwk8M0Zo3ZtpA@mail.gmail.com>
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
Hello friend did you receive my message i send to you?please get back to me
