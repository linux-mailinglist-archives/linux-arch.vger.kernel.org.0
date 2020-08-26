Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C471C253A8F
	for <lists+linux-arch@lfdr.de>; Thu, 27 Aug 2020 01:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbgHZXE5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 Aug 2020 19:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbgHZXE4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 26 Aug 2020 19:04:56 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F23C061574
        for <linux-arch@vger.kernel.org>; Wed, 26 Aug 2020 16:04:56 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id g1so1942202pgm.9
        for <linux-arch@vger.kernel.org>; Wed, 26 Aug 2020 16:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=emKSUp3nMJDf6YlCyIrbjlqxOTOuxbCiHuWA2WLiJTA=;
        b=VVR6FzqsCKKTDwvmPzHJGdzYwKsiXM5LElJdkyEycS6c8PRBzk/YvNqFW09Pe/85oS
         lBZy30JPirAAfmZjsIs3DGBd3E6QGHblWJwFXzequYkP/Nr4hMpaamzC0dZBXAyCoPUP
         L4HEotCYHlzilahe+XeozvesLJuKGSRFweJq5FZYyVvPFfQMlH43u87dsce8sMIKiJTf
         JCVuDEMsxMWKl9jKjIckBz5SBd1jC0hG5IvD56pq4jp2fQvoVKaMmxGk+Cbgx0OmXrgy
         DLPksyt3VlU1m0FAaVGcN4ffe5ISVP8fqbijsGE8I3mFqv0H5+7GNa7xwyg3JhIMF15Q
         L+/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=emKSUp3nMJDf6YlCyIrbjlqxOTOuxbCiHuWA2WLiJTA=;
        b=bhmWFfD59j6vyxjsjRnaENMvJxJGUWMVRcsuKGCdgw7RQYeSsEmNUr1mH45baVEIpW
         FDJJAx3Vd+5dTdWpJKoP6j1QIIxjsI5RdtuKHM5oRRzUb4/6NDZG7OXd0TjVzU0COCzG
         aasV4OOQDVOAhcC0PMIidDFghkTMIR4D6sBLM8XcYl9/1NFmPHyGzwvJ+F4lphzFRCbW
         iQdQy9IA6+1OQV4Za7eajEWEUFCdzQ2b7yp5KyCksu89s5P4hjYONjTMCtDBJj2YNfoB
         2MHfoUK20WBjPGyAk9YtnUvdADvX2qSI/33psBQrXo9ocj4G8WupB0HT1BanhWLn7RCl
         cwuQ==
X-Gm-Message-State: AOAM530MTGZulR8qyGbLk/BGITVFu9oU4togdsgUiX0PhkPD4hZi23kI
        +yQE2BkEgothKK7Tl3NxrzhDTvhvvJDdCA==
X-Google-Smtp-Source: ABdhPJyetZjoo6u6Lr44hDUQngV8PCD1zh2VcrJgJUNKLXuMi8Co8Bz27dLcebrrXDCqD2/1IUKABg==
X-Received: by 2002:aa7:9467:: with SMTP id t7mr14128163pfq.64.1598483095862;
        Wed, 26 Aug 2020 16:04:55 -0700 (PDT)
Received: from VM-0-6-centos.localdomain ([119.28.90.140])
        by smtp.gmail.com with ESMTPSA id x5sm248639pfj.1.2020.08.26.16.04.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Aug 2020 16:04:55 -0700 (PDT)
From:   Chunguang Xu <brookxu.cn@gmail.com>
X-Google-Original-From: Chunguang Xu <brookxu@tencent.com>
To:     arnd@arndb.de
Cc:     linux-arch@vger.kernel.org
Subject: [PATCH 0/1] clean up the code related to ASSERT()
Date:   Thu, 27 Aug 2020 07:04:52 +0800
Message-Id: <2a79d3f5feb628ab318fcebe004e398b8124ce46.1598481550.git.brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The kernel has not yet defined ASSERT(). Indeed, BUG() and WARN() are very
clear and can cover most application scenarios. However, some applications
require more debugging information and similar behavior to assert(), which
cannot be directly provided by BUG() and WARN().

Therefore, many modules independently implement ASSERT(), and most of them
are similar, but slightly different, such as:

 #define ASSERT(expr) \
         if(!(expr)) { \
                 printk( "\n" __FILE__ ":%d: Assertion " #expr " failed!\n",__LINE__); \
                 panic(#expr); \
         }

 #define ASSERT(x)                                                       \
 do {                                                                    \
         if (!(x)) {                                                     \
                 printk(KERN_EMERG "assertion failed %s: %d: %s\n",      \
                        __FILE__, __LINE__, #x);                         \
                 BUG();                                                  \
         }                                                               \
 } while (0)

Some implementations are not optimal for instruction prediction, such as
missing unlikely():

 #define assert(expr) \
         if(!(expr)) { \
         printk( "Assertion failed! %s,%s,%s,line=%d\n",\
         #expr,__FILE__,__func__,__LINE__); \
         BUG(); \
         }

Some implementations have too little log content information, such as:

 #define ASSERT(X)                                               \
 do {                                                            \
        if (unlikely(!(X))) {                                   \
                printk(KERN_ERR "\n");                          \
                printk(KERN_ERR "XXX: Assertion failed\n");     \
                BUG();                                          \
        }                                                       \
 } while(0)

As we have seen, This makes the code redundant and inconvenient to
troubleshoot the system. Therefore, perhaps we need to define two
wrappers for BUG() and WARN_ON(), provide the implementation of ASSERT(),
simplifyy the code and facilitate problem analysis .

Maybe I missed some information, but I think there is a need to clean
up the code, maybe in other ways, and more discussion is needed here.
If this approach is reasonable, I will clean up these codes later and
issue related patches.
-- 
1.8.3.1

