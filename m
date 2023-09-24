Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 746F47ACAFC
	for <lists+linux-arch@lfdr.de>; Sun, 24 Sep 2023 19:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbjIXRUv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 24 Sep 2023 13:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjIXRUu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 24 Sep 2023 13:20:50 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6951FC;
        Sun, 24 Sep 2023 10:20:43 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2bffdf50212so79813781fa.1;
        Sun, 24 Sep 2023 10:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695576042; x=1696180842; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NYwWt/Haldb8Z9AhFR/B5mbU054gJ14PDUXSNrrFlQY=;
        b=SLg28wM7Sq6fZCD79cOLIGqiwlJ5fKmnUkb/iZhFqicttIBD0wFPaIaWTKFrdq75yH
         n6ogo4muYANW7ItldshUtM9VqQIcDzcNEySRBRaBEEjvPZMKtF+t9Q6hOgqoWWszrNf1
         hOIv8QVD0wosawdHSfLywHgpHlUpveRR8JzvNgSqXvRokpoD4ysGATx/0kdi3clLye+8
         2EageKMG+PHlJByAVZLeFKLNXkqnjVIQD3Up5t4VEi/dfHsQmgLAq6LQG58bGqbmi7Tm
         0bzih3HnCPhKx5ebwL6YjUgI2dIxgV544w70+7mQQLTDtaQpGqPrl/viRY5xv3Shl6LB
         NTng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695576042; x=1696180842;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NYwWt/Haldb8Z9AhFR/B5mbU054gJ14PDUXSNrrFlQY=;
        b=AJ640m7anAf+KqqJGaiDwEwrebqSpykJNh/eFnQH6BYI3OuPEd/jYbntYcuSoeq81q
         W5Yf4n7N1m9VcYk8r8DR+VWTbd6nBuyeJbn8XPmy36NKiZKkXCcRvGKQFLquwmHVajcP
         cjiGr5e6o8qCs4TYmpsydIOzuOEPnwCTuUSZ21qf7ti9L3EBESZQjacWjlVv9ZAqs+OJ
         ejXIVwUk22fwpMAcXnmZK8jNZqghWQONSSujZ7FtR9B3mWv2cOsURGmJu92jXCBXiSck
         lYrSfveCTkQW7jEmSPLU3uuqNx93HnP6tJjf4yAzE2ethj0iGixabYK2X/pj/9I6p5TO
         cj0A==
X-Gm-Message-State: AOJu0YxZ5e5F5Agy0tfGPI0TgLjIFcx4p5CcXXE9NNk4xvQcgS3ugTs/
        Yrh5UrqgIbGDebLPN+3XawK1f9gOjMVsMGUFOEUp6d++gpw=
X-Google-Smtp-Source: AGHT+IEUXSewh5mor/yQ4TIYsU+GCIGbe7Ycr82z3d+389uXGX/eiZ2hQLEKX6/jK8/y/rn0nCCiZQT76PpKSKhLxE0=
X-Received: by 2002:a05:651c:19a1:b0:2bf:ee57:f18 with SMTP id
 bx33-20020a05651c19a100b002bfee570f18mr2922293ljb.16.1695576041711; Sun, 24
 Sep 2023 10:20:41 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?B?VG9tw6HFoSBHbG96YXI=?= <tglozar@gmail.com>
Date:   Sun, 24 Sep 2023 19:20:30 +0200
Message-ID: <CAHtyXDfvS4OYLjOqALy74vR4w9DOFjJ9z8UOFeDpyjv7_PHNXw@mail.gmail.com>
Subject: ia64 maintainership (resend)
To:     linux-ia64@vger.kernel.org, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hello linux-ia64,

I noticed following the news of the proposal to remove ia64 from the
kernel that the architecture has no maintainer. I'd be happy to
volunteer to maintain the architecture, should the decision of removal
be reversed.

I'm not the ideal candidate, since I never contributed anything to the
code, but I have an Itanium machine running Linux to test on, some
spare time, and I've contributed a few patches as a part of my job of
kernel developer at Red Hat.

I'm also a contributor to T2 SDE, a source-based community Linux
distribution supporting various architectures including Alpha, HP
PA-RISC, and Itanium. I have interest in the architecture, having done
some experiments on it with code performance.

Tomas Glozar

PS: Original email got sent in multipart format by mistake, re-sending
as plain text, sorry about that.
