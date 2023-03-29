Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD2E6CD5B2
	for <lists+linux-arch@lfdr.de>; Wed, 29 Mar 2023 11:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbjC2JAC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 29 Mar 2023 05:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbjC2I7o (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 29 Mar 2023 04:59:44 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 488FC3C14
        for <linux-arch@vger.kernel.org>; Wed, 29 Mar 2023 01:59:10 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id x3so60233018edb.10
        for <linux-arch@vger.kernel.org>; Wed, 29 Mar 2023 01:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680080313;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UK4Nxu8VuNlDMW0oI9hxwlYcdkLqjNPKCstHpYnJQtw=;
        b=HqMI0i9Mee6JSnO4ZyYf1XQT+bOTCZK8FMKmgd9WxbHrDCOTLAeHFh9RcWJkpJv1Uv
         lQx7Eqfuo/7UpgqfNAvXM3Khh6Virl68b9KfTSB/Eo8FVepCPse3KorMhGfRdq3Sv81P
         64ylHKXP5SMyDCpQYq8bz36Gab2fBf/uAjIc2PHrC1nlNvWfG576u5FSNpiyrmNycJhh
         cynwN1DlvD0n0cwkJj78DogF9ZA9c/5rd6Z+5gE/cm65Jq5MSbu43WeKknp9dkAhbL7T
         qYjTt81nO8M5UD3OfFo0Uh+SFyQ9vDciKNEyBBHkKyv0EOIPj8xUqREM5vqMA30pw5kl
         R8Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680080313;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UK4Nxu8VuNlDMW0oI9hxwlYcdkLqjNPKCstHpYnJQtw=;
        b=7AK+iQ16d9PcCg5z52dkTJgsEhd0G4X9Z3zBmb9qX1tVu1Sa59GxZm4GGPrA6LwoqG
         PabkUpQYEsREs1O6rkN/EOlgkXmkJbE0DLjfzM2OrxtEPIl+lnxcndlxXSn/044HG0dz
         kHSt7MqUFtQmau7FNPN8BFHJdvfBMlJPHFXIR67vtpTEIFyfDHaoVGN0gq3kw5EVqMwd
         yzEgj5jeDymGgA5MIJDpPS0sk/Ea9cLReeJSXgUDiq4lYR8Ms1rwHTk8XNo8v4JkgROo
         5x0xYfcyIwgrg3ilkgdvqqF3epnla6cxDB5y3q0FecIqI1oJcZm6ykQC578cjBK9clso
         yO3Q==
X-Gm-Message-State: AAQBX9cngH8i3bxCh73/pZm1ghoiJpoGeM7i0hCXXIbKCK1jCMAw+mKM
        wsKMvlVSw06dvcgnax7mD9mmdOPuX/iTi+gIEP8=
X-Google-Smtp-Source: AKy350bUpnZswl0vyKM+pSu/u2M0VSoq2LDmSJBJ4kjhmaOFIH22QwZ2c8BObiXCo+DYFsTtIm8ZwjTTTF382fn2YH0=
X-Received: by 2002:a50:a444:0:b0:502:4f7:d286 with SMTP id
 v4-20020a50a444000000b0050204f7d286mr9127094edb.4.1680080313728; Wed, 29 Mar
 2023 01:58:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:907:80c4:b0:933:4577:4f9d with HTTP; Wed, 29 Mar 2023
 01:58:33 -0700 (PDT)
Reply-To: fionahill.2023@outlook.com
From:   Fiona Hill <thankgod07062@gmail.com>
Date:   Wed, 29 Mar 2023 01:58:33 -0700
Message-ID: <CA+wdF_GcC9tqMuOoBgm33KaMX1k4KBiZ_CTxhiDQ8RthhC5e0A@mail.gmail.com>
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
