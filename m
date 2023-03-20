Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD0786C1F95
	for <lists+linux-arch@lfdr.de>; Mon, 20 Mar 2023 19:24:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbjCTSYo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Mar 2023 14:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbjCTSYI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Mar 2023 14:24:08 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2376033CDB
        for <linux-arch@vger.kernel.org>; Mon, 20 Mar 2023 11:17:19 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-544787916d9so238637877b3.13
        for <linux-arch@vger.kernel.org>; Mon, 20 Mar 2023 11:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679336222;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2EunEBKVYoEoq69imBRqQomGfF0cWJoxl6o7vJ+JiVg=;
        b=nASx186ylC8+CvmJWOwx2v/yKfAZi0Xaz/XTnjcDjXg8ciDMvkRQsp+eqdobwLkqjc
         cFkN+2FN7BbnQYpFbUUHlYISwHiQgYcdQTNhXi5oM3qwArm8Wp4JwsYZUgfC6FHbqGi7
         muRkNVMIfQuCbjhDrUoMG6m000XS+Sux0xSRzQzqRZKOgh3ZSzST0dr7U1HlgC++LF9M
         08Op/vyqbq8lnq81WUgU637mFsvFxlPNSPr/ZhvEwrj4if/xvJ2W7y8YeMpHjjp9cqz+
         yXjXDmlvLZM4b8QGvYQYrJqlyIC1wPxN/evf2vDsCInPl9rl4U+fIT5m/AlpWQEz2VKZ
         bTYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679336222;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2EunEBKVYoEoq69imBRqQomGfF0cWJoxl6o7vJ+JiVg=;
        b=bMlqww83uxBIQF5x0JKGgISORiFz+tA15UQ/5UpN7D9DHSI5IvH7f0l60yZHnjwDzH
         bAlrlZbP2dW8PTqSEJWVb5VUkAKOUol1mgYVe7EZn93mue0XmBuTSaYuBOBYrIuKT8y2
         BFE929Ywq64GQ8a5MkemlDAamDxDHZ2vvDAZO6COa8JoEx1ITB56jUB1bbfnIX96sMXW
         JPaQCqFF1q9A0zZwD8mB5sHA/dheieRlA7lXDWGGeKvSQWnIgx5wqifiKzgdzqg3qSBH
         DP9AqlLOdZ+Cdtx3sLbovBey1JzgedHjLf3NJgXRBfD36B9DrkCgop/FOFNrkDou65h/
         xueA==
X-Gm-Message-State: AAQBX9dDWA9JicYgAFm47VWSC/dvcrawyuT7ttbpxWQTbqnEpQK+cqwx
        vc7WN3eXV4D/ReESBIxnYch2iv3kUtCOcFILMA==
X-Google-Smtp-Source: AKy350ZFBed1yqCb1oCL0txKdys2tV7yXxKvigA0hpWbrepKcmw6vlqKb0Al+KP+MFeGfL8mZGdz7eGPo8ooUoV4kvc=
X-Received: by 2002:a81:b64e:0:b0:52f:184a:da09 with SMTP id
 h14-20020a81b64e000000b0052f184ada09mr317249ywk.2.1679336221965; Mon, 20 Mar
 2023 11:17:01 -0700 (PDT)
MIME-Version: 1.0
Reply-To: vandekujohmaria@outlook.com
Sender: dm558639@gmail.com
Received: by 2002:a05:7000:b293:b0:491:8ae:2968 with HTTP; Mon, 20 Mar 2023
 11:17:01 -0700 (PDT)
From:   Gerhardus Maria <vandekujohmaria@gmail.com>
Date:   Mon, 20 Mar 2023 18:17:01 +0000
X-Google-Sender-Auth: XN533eDsDvWr9GzD7TS1ZcUKFAs
Message-ID: <CAK1UNhcg8WCRWqYbAXcn-O3E7uAd_6gKGYQZ4RfFqK2QdgMpew@mail.gmail.com>
Subject: Good day
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hello Dear

How are you doing?I'm van der kuil Johannes gerhardus Maria. I am a
lawyer from the Netherlands who reside in Belgium and I am working on
the donation file of my client, Mr. Bartos Pierre Nationality of
Belgium.  I would like to know if you will accept my
client's donation Mr. Bartos Pierre?

Waiting to hear from you soon
