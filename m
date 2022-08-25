Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFC8D5A0D80
	for <lists+linux-arch@lfdr.de>; Thu, 25 Aug 2022 12:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbiHYKHb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 25 Aug 2022 06:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240558AbiHYKHb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 25 Aug 2022 06:07:31 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80708A7AA2
        for <linux-arch@vger.kernel.org>; Thu, 25 Aug 2022 03:07:30 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-11dca1c9c01so7371353fac.2
        for <linux-arch@vger.kernel.org>; Thu, 25 Aug 2022 03:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc;
        bh=NcQgfGWmNtGVcmYOkqhvmNWuEth66CXwSKmPdJfqqgM=;
        b=gS71PEVjyzU2xpIjj3iO6sfMt0N8eLnR00ZiQe5eoTYuK0jXg4rACt5L0Igwocd6Z/
         7acOpwQXcyxQd8eE9QOQID3gxWCKZV1A+SElanNWrtiDAHp1rgM9Y1Zx07WGW1dmJbkU
         zQoeNCTZZq7d2o6NcgFqgGceKCIJ4SaIPD97zb0bd4NjV1zgb1Kt+LN5F6FsEce2hp+4
         hXwDB1JVe27zsd2jQVBFy5VF/XboTmXDwZlxJ2Zm5yQZIMok6Btkf3ml5b59khALc+PN
         LOe8rkM5/OVLNcNabbO39l8/ZyOR0T1I8Ks+QM6p3VAmuQNq+IR0q6e7Ple+MoSOQ6lT
         IGNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc;
        bh=NcQgfGWmNtGVcmYOkqhvmNWuEth66CXwSKmPdJfqqgM=;
        b=5YkPZ5WrMXeNajmoUIFFkANY4aXkaR19ozpXKTjxRe0zyYniXN2tBKWNH6rbQ4kS2e
         bcZT0aVqAG6/Pa1+/yuKTxisQSGgj/O5b62qCGJlHKP6aUk9JkOg/wsEsZBMhRetGDkM
         SPSo/KR7QxpaUz/8nUuvMWbK7MYm2CmeG7OahCwL6kcgpA5Y9T2xg8DaT9+pR4PICKy+
         uDbOsdKwpUpRWKLz/Mdkb9vm3baFOVN/c9xyDT/yNt0d7RF018wzt2+GorvqINv+mAZ8
         Kd9uHC6ZxTjD3Rge8BvlVKWW1iGJ+PIfv7cCcDKAsUXFFQ9h4HM0rbfblfxNQjnVmVga
         qQHA==
X-Gm-Message-State: ACgBeo0d/9GhsKS5aWikt1xzpzdiLN0XDyn5sTEPlnoqXoFkGUGjaldg
        4krRaOnzqLZS25BNeLX+b6iJyfIU2EB9TuwvfYc=
X-Google-Smtp-Source: AA6agR6JrfSAkfdQ8XLMw3rMIgEK7X3pMGa0c/wGPH0OqOv1GpJndYY26GLaUFJfY+T/Wzs8iccJFeA/ykSwsQ9XEZ4=
X-Received: by 2002:a05:6870:b51f:b0:11e:39c8:cc10 with SMTP id
 v31-20020a056870b51f00b0011e39c8cc10mr264075oap.184.1661422049966; Thu, 25
 Aug 2022 03:07:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:5ec3:0:0:0:0:0 with HTTP; Thu, 25 Aug 2022 03:07:29
 -0700 (PDT)
Reply-To: sgtkaylla202@gmail.com
From:   kayla manthey <tadjokes@gmail.com>
Date:   Thu, 25 Aug 2022 10:07:29 +0000
Message-ID: <CAHi6=KYvX3Cxsu8Xvf495nkVue4N1PftMxQkSOBqhija7Ychjg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2001:4860:4864:20:0:0:0:2d listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4991]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [tadjokes[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [sgtkaylla202[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.2 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Bok draga, mogu li razgovarati s tobom, molim te?
