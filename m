Return-Path: <linux-arch+bounces-4173-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F40F8BBA77
	for <lists+linux-arch@lfdr.de>; Sat,  4 May 2024 12:14:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C4DBB21834
	for <lists+linux-arch@lfdr.de>; Sat,  4 May 2024 10:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A51625258;
	Sat,  4 May 2024 10:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e+B6Ghap"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FB14689
	for <linux-arch@vger.kernel.org>; Sat,  4 May 2024 10:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714817642; cv=none; b=J8Wwr6vM9tZwn+aO1fnpoIM5UtDOCzDR9fju1bAF1dPlNLpMI7I7SJLWAapHYVpRGtuQNDf4md22t6JF5a44KtYL+mWpZRNdrd6uJBw3GtWTfve4UXAlRuw2wOAPK2eHVfV++gVb/n5rJxdj/9cGLKAJz6M4R+DA/Bgb4pSebiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714817642; c=relaxed/simple;
	bh=ioqI8GmqCOX7v772X8a1cq0S0gVDoQ1C+vDfv3g2vGQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=jmL1lSI/im04C3sVWhXioKqwWmjYRLk/GlXHid5xkt+BmctjjsHYchiJA+Rr/9L+quLsThQKp2zhn6figj8isRreAYp58Yje4Tbyi2wNGc79WFd5dGsKIJpUYd1hmnNzzXXh1kDM+uM7iKiFAmWmqmqxZ4gT2kD39RwlzyE34bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e+B6Ghap; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a58772187d8so93466066b.3
        for <linux-arch@vger.kernel.org>; Sat, 04 May 2024 03:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714817639; x=1715422439; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=p3oCmjCoYMwLy3db7DO4W24L+oY4O7PgXoPsG5EapjU=;
        b=e+B6Ghap0jakFwfr5kpHoe+omn5SkxopYtGPRk4r0pwsGXXcWmQCWs7ZD/75GDD3ST
         ymbI46/Jz60AUtTzSaE420Cjr05yWdlxVIT9aZIr5aHakeErEb8iBHgrqiM026MvCbtg
         Fx55SXJU4Yq9Ocl8wMvYCXcqMhcJMdBeg/WuVPdieD7f9WABDsCILKdJKdA/SyyOmBnV
         EISDcX3VhRugCYheWSDvFveWfTNkRjrg4HUGl6dxWkJmjQOW0fez7W2Y2Qs82swdMkRU
         4Vi6gPwwQbxvh9AjdC2ky228E9Kblf7D3aP891vpKKoPzxEaBAQXLsoVe+W5BO+6ETPn
         w1yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714817639; x=1715422439;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p3oCmjCoYMwLy3db7DO4W24L+oY4O7PgXoPsG5EapjU=;
        b=qGILA2Zwq8JVSJaD9UXMqYNZsLbiobPAxW4lsIMRGgd9cO+FuyiWYvWimI0YFtdZA/
         RhiBmo9gf2RFfEbSkCSEDJpLQyxNJkgmK9Zym2RpB65aTtxNS5WoFz1T+2cbEl/8EwzR
         51ZJvPMOhf9KSLpUVv9rMPVINPygG6WB6BIOTJ7r5zOQMR1RN+oEPl5X++6i2veQrIA4
         4S//vjoySZpvrwJMafPuj7xL6SS6wFqEjR863CI9W8bz0cwnV71r6IjQdUuhi1YGr28t
         qciEkhR7yr5FqUXiU8JzHFEiXcpQio1kDVeMm6rfH6pOQgLFq/JEXgYIQVnkE0unlXD6
         sWAA==
X-Gm-Message-State: AOJu0Ywmdw/CSGl9WQbobgG+lBXrOJM0OYL3o9TPoAqtTmj/SjAY7Ykv
	xG5QOdpN2sbGks4i1nKtAV+W/drtn+H3j0THwRhMB0kqlPXivLSC61DAHTQHNKPShZmqp6ymmST
	5+FjuuMke0SeExvyGAGYyKZB0vYsEVevqSyStdA==
X-Google-Smtp-Source: AGHT+IFKxtdXFbubtSdXNvlq18g7ZkW4VKohMfCy3iPA/EYfJ+lIWagImIxDoQM1Gb2G1kPMWYVEppdY/oYz/0dfF3U=
X-Received: by 2002:a17:906:b08b:b0:a59:a3ef:21f5 with SMTP id
 x11-20020a170906b08b00b00a59a3ef21f5mr1498164ejy.57.1714817638925; Sat, 04
 May 2024 03:13:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Dr. Amr Osman" <dr3mro@gmail.com>
Date: Sat, 4 May 2024 13:13:22 +0300
Message-ID: <CAEYFr1BWABEZvHSV_jizxFF2W1auO74-gRCpwi_ny_tretRwhg@mail.gmail.com>
Subject: Fix for vmware installer failure to build vmmon and vmnet kernel modules
To: linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

when using vmware installer on fedora 40 it fails to install kernel
modules due to missing declaration of random_get_entropy_fallback in
the timex.h unit file this patch fixes it

excuse me as its my first contribution to the linux mailing list

here is the patch
------------------------------------------------------------------------------------------

--- arch/x86/include/asm/timex.h    2024-05-04 12:35:23.000000000 +0300
+++ arch/x86/include/asm/timex.h    2024-05-04 12:38:44.438340770 +0300
@@ -5,6 +5,12 @@
 #include <asm/processor.h>
 #include <asm/tsc.h>

+/*
+ * Fix for vmware installer failure to build vmmon and vmnet kernel modules
+ * as random_get_entropy_fallback() is not found in this unit.
+ */
+unsigned long random_get_entropy_fallback(void);
+
 static inline unsigned long random_get_entropy(void)
 {
     if (!IS_ENABLED(CONFIG_X86_TSC) &&

------------------------------------------------------------------------------------------

Thank You
Dr. Amr Osman

