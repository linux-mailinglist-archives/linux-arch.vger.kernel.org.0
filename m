Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0826D3ADDB7
	for <lists+linux-arch@lfdr.de>; Sun, 20 Jun 2021 10:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbhFTIQq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 20 Jun 2021 04:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbhFTIQp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 20 Jun 2021 04:16:45 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A51CC061574
        for <linux-arch@vger.kernel.org>; Sun, 20 Jun 2021 01:14:32 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id h26so161692pfo.5
        for <linux-arch@vger.kernel.org>; Sun, 20 Jun 2021 01:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=XIV/ZVf9L9J0riDbCeYYDPLzprfr30uDHayyxURrcKc=;
        b=F0jWf2bDCUvr1D08Jyrfl9SdaGw4rgAcivmBfqWQivEkAf0RnzT9CA2Sg69TtcD4cs
         /yKtrPQ93a7wjA2RaupaIGOyLh9xia/oulQ26wmYJnLMJo0LaZbcG1mlNiVMuBK88mSp
         1gLTZLNIblRPXUx6Hzeq+s7/0PWLc/VueMi8i0ToEAPEixYIgHwMdYmqsf2FAPvFZuFL
         KxR9XlQhgno6Sn0rXNOIhYkih2zi5BLDropZF4InZeocnP4C39x0hRqFtCPgsRyHzgIY
         yf5RpxV8PUF663hQNqdPBVR0LS9FG93sTzxEyzbgpjqjuSnzYSd7VS5UfVsNzzr/9ieZ
         9pEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XIV/ZVf9L9J0riDbCeYYDPLzprfr30uDHayyxURrcKc=;
        b=VWq/nWy7dr0X/LVMcwrVmReCTeDaEjquKGeCc9CY0tQ41bOci1iGVKPb0fYfXod4Ec
         5nCb7oScAf2Q+zhsNcE2fQV3HZaTDVEYoi1A7ccZAk9gc2OChtmL8rD3NLkWnnGQOBj7
         BUQz8esbwJEa3zrEmk2/GqGZZBOH75bg/RoO+evySAuGA+Uq+Q2PAtRsuKYzj443aX3A
         Df3fSYPdZKYKrwB1B5Z0rF/APIjjQhdC1zHMlWyPpApVLXbJEAirdmtG8pqi6GeE28PI
         1nnne1dAWq8+QqA0CKwiqPZkv8CN2PU+HOOWdKnXnED/00emfQoFkebrVOS0XuV8qF/4
         +tnw==
X-Gm-Message-State: AOAM530zp6Q/UkNskxGSa3LKGxG+Emf56fVLILH5xJpT2BBrevfty/LH
        o0NH1TyFmwk+hf7LpOBrVY4=
X-Google-Smtp-Source: ABdhPJywG3sIj+1VcRiEom34FMI1obI0+/CubUmbo5lC/Stu0oXW9zNhOkBQ15Uk9x+9kPhoNiHCOg==
X-Received: by 2002:a62:1d0e:0:b029:2d8:30a3:687f with SMTP id d14-20020a621d0e0000b02902d830a3687fmr13553412pfd.17.1624176871953;
        Sun, 20 Jun 2021 01:14:31 -0700 (PDT)
Received: from xplor.waratah.dyndns.org (222-152-189-137-fibre.sparkbb.co.nz. [222.152.189.137])
        by smtp.gmail.com with ESMTPSA id a9sm15012778pjm.51.2021.06.20.01.14.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Jun 2021 01:14:31 -0700 (PDT)
Received: by xplor.waratah.dyndns.org (Postfix, from userid 1000)
        id 72101360145; Sun, 20 Jun 2021 20:14:27 +1200 (NZST)
From:   Michael Schmitz <schmitzmic@gmail.com>
To:     geert@linux-m68k.org, linux-arch@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org
Cc:     ebiederm@xmission.com, torvalds@linux-foundation.org,
        schwab@linux-m68k.org
Subject: [PATCH v3] m68k: improved switch stack handling
Date:   Sun, 20 Jun 2021 20:14:22 +1200
Message-Id: <1624176865-15570-1-git-send-email-schmitzmic@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

m68k version of Eric's 'improved switch stack handling' patch for alpha. 

The first two patches address m68k missing saving switch_stack on
those syscalls that can may call ptrace_stop(), and adding a full stack
frame in kernel threads.

The last patch adds a 'status' field to m68k thread_info struct, and
stores information about whether a syscall trace is in progress, and
a full stack frame has been saved, in that field. This information can
be used in arch/m68k/kernel/ptrace.c by get/put_reg() to guard against
accessing incorrect information on the stack (haven't got around to
that bit yet). I'm quite certain I haven't picked the most efficient
implementation here - suggestions to optimize most welcome!

Cheers,

   Michael



