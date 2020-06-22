Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 641482045E6
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jun 2020 02:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731876AbgFWAkP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 22 Jun 2020 20:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731625AbgFWAkO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 22 Jun 2020 20:40:14 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A6FC061573;
        Mon, 22 Jun 2020 17:39:34 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id j189so17349124oih.10;
        Mon, 22 Jun 2020 17:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8gg5xcfbj2whqXxmSEa9T/iWOw2YwyVIV2mrfaawyUE=;
        b=iBqtOtj6PpiscFSPYPQwVkLB3pum2HERpu/4Zbx3HuodXjwvGfuDEjUADFUPcnmJkT
         0q3lFKM2x4/sNmAQytMDGbS6DJdlHvvxW7hEIRemFt4mI00wyTIIU2rWmZ39kgbpQHei
         Vo36HARttyGRuF3D80oVRnp4OXoN7MvDb4FaJb+x3vtvF7ANKAl8+YbbgJQ4wrFtYT9s
         rDuBrct6kpUAzUQvFg84HY38NmcXS9QBjcxj1WFGcQUpSBob+Lce8qJej4Bzl/8Gcs/O
         y/kLRFQzmjcWBhjmTq+Cdt+7eQjgriUmPBj3p1evFawWxas1mT3DfhqYEy+wKuEudafe
         1IDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8gg5xcfbj2whqXxmSEa9T/iWOw2YwyVIV2mrfaawyUE=;
        b=SNP//5M8tRdLeU0VpGuCPn+ICTBSaCnTfb9br9iws+73Uz+TDaj8ldXMViLD4XCtu2
         eIYtdCPtUOREML8RLLvin+qm+2yxZH3hBgwMBXtcTOvFzY9w1gREyKzx1KUU41l4HEim
         um28lDOdzsrNHn74aPCWnqPH0rD9Cc1AwQVeFZMx1zvYzjwv4EE/cNJ7bMpoSktz8rK+
         sK+fIkkQoqzLjcMKsHp6cDKewlh4i7bD3PtcvQiWkNJUfIQo8eVJWO1oAVXj8rdgBWF4
         INdaYeeYP728VnEYVJr3fV+/FjsuMMcuW0fzn7JG43uzJfdGmnT8AzAxI7kPgrdn9E3u
         7IdQ==
X-Gm-Message-State: AOAM532qTHPYiXcCtJ9IYtjVHRFTUbzKKIYW6MEWv6EKzb0HXh0HBajv
        vaXQC5b70WjYViayU7wbGKNfZ6Hg
X-Google-Smtp-Source: ABdhPJx8hTNMnfiRhhP2jbOGvs6MmoC/nZk9+07kzXuHFoV0Tu0ZpvLDzw6IBOGmsupvMEvAIlqCNA==
X-Received: by 2002:a05:6808:295:: with SMTP id z21mr14399674oic.178.1592872772765;
        Mon, 22 Jun 2020 17:39:32 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:4111:8b00::3])
        by smtp.gmail.com with ESMTPSA id y31sm3677828otb.41.2020.06.22.17.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 17:39:32 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: [PATCH 0/2] Small fixes around cacheflush.h
Date:   Mon, 22 Jun 2020 16:47:38 -0700
Message-Id: <20200622234740.72825-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi all,

These two patches are the culmination of the small discussion here:

https://lore.kernel.org/lkml/CAMuHMdVSduTOi5bUgF9sLQdGADwyL1+qALWsKgin1TeOLGhAKQ@mail.gmail.com/

I have fallen behind on fixing issues so sorry for not sending these
sooner and letting these warnings slip into mainline. Please let me know
if there are any comments or concerns. They are two completely
independent patches so if they need to be routed via separate trees,
that is fine. It was just easier to send them together since they are
dealing with the same problem.

Cheers,
Nathan


