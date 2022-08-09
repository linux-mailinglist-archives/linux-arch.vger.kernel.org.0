Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 678AF58E2DA
	for <lists+linux-arch@lfdr.de>; Wed, 10 Aug 2022 00:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbiHIWQT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 9 Aug 2022 18:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbiHIWPJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 9 Aug 2022 18:15:09 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 768B013D02
        for <linux-arch@vger.kernel.org>; Tue,  9 Aug 2022 15:15:04 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id f28so12045258pfk.1
        for <linux-arch@vger.kernel.org>; Tue, 09 Aug 2022 15:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc;
        bh=GI1h58u9NHz7rI/vIwOU5DkUcoHPmL+b4tk5i/xxv5Y=;
        b=QTP95oQi+RYhXbI8sz4RyTZp0RSE4jP48cyyUmWbTiK1ItvOHbADVtjkGHK/8zFbqv
         EIzUG3d4HgG5eAQxnVHuBpH33ycuIiNpMEXk8S0LHARhhQGb6AufQVVn/40aQfLvP77W
         778oK7qnpGZXO0Q2aGCYT4Mad4FGDHlh1br3s7D4D+9Vr7gPQrhXDR8bwR1fyz6kQ1n2
         /mI7/+oIm6xqfpBjeRephfywWnzvzUcqvvdKwYuFsxmTm/GRVEQb9jKfBsLPvHEPeyBR
         SLk52BQ10Zm7GZ4Mv5gugSKJZhGFXVOipaGDVsAOq6ABLyMrmGMv+5RYTjL3cqduwO+M
         O1Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc;
        bh=GI1h58u9NHz7rI/vIwOU5DkUcoHPmL+b4tk5i/xxv5Y=;
        b=ufeYMPVgX6/H3D3n1LuEl0tIW0IrwdqdPN9COfOK/xkv9VyZNzWVMx2QriGzFydRZJ
         8urMJ4GPiYAKDlq/py3BxuLlL9SWKe5alBLhiFAsDuqTYuqmWq1LYxPa999DYJ4eKG3/
         VVnGjZ0bTO7XpUeOS44ju1OHdrB2mAf+hVUtv+Tk4pdxusRo7Q2PLHLQFmQJYJAobM3d
         eIGJ1wvsNIrR++N0YTUSpZ9r/+VsjDOFg3Me6I3Af0Qz5FXOuayRwnq3ShC/zswnJl2r
         dSxjkTyw3fQUTzEUedBCPO3IagCSIh0zif7k/jHdIzor3NEz1IEWaHAOnmP7u/WxgvJ0
         ZosQ==
X-Gm-Message-State: ACgBeo0ZqamS//slWboymvLiC0IebfI90suKJqMabbPU4gn6iGujyYLP
        36I97DLYLf34+g0bUifYnW7TU4+L4mtAOKZ1BVU=
X-Google-Smtp-Source: AA6agR7pJ6r7fhR2kV9XLe+oV3h+/ej1weqLnpTQS1YP5ule1vsDwGSNCnOW6LlEIY2xTapZFY+hu5KXPqSjTYpoaJM=
X-Received: by 2002:a63:4642:0:b0:41b:d353:c5c7 with SMTP id
 v2-20020a634642000000b0041bd353c5c7mr20359415pgk.568.1660083303718; Tue, 09
 Aug 2022 15:15:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a10:e8a6:b0:2d4:fb1c:cc5e with HTTP; Tue, 9 Aug 2022
 15:15:03 -0700 (PDT)
Reply-To: wijh555@gmail.com
From:   "Dr. Ali Moses" <alimoses07@gmail.com>
Date:   Tue, 9 Aug 2022 15:15:03 -0700
Message-ID: <CADWzZe65tcOX2+bMZfMLLauGpHEQ9Cdv814nLU=uQvKzDFrEVg@mail.gmail.com>
Subject: Good Day,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:42b listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [alimoses07[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [wijh555[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [alimoses07[at]gmail.com]
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

-- 
Hello,
We the Board Directors believe you are in good health, doing great and
with the hope that this mail will meet you in good condition, We are
privileged and delighted to reach you via email" And we are urgently
waiting to hear from you. and again your number is not connecting.

My regards,
Dr. Ali Moses..

Sincerely,
Prof. Chin Guang
