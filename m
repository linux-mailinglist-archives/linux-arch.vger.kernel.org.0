Return-Path: <linux-arch+bounces-13930-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC06BBE903
	for <lists+linux-arch@lfdr.de>; Mon, 06 Oct 2025 17:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED9653A5B90
	for <lists+linux-arch@lfdr.de>; Mon,  6 Oct 2025 15:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2784B2D8DA9;
	Mon,  6 Oct 2025 15:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IiPT5VJk"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B617B296BA9
	for <linux-arch@vger.kernel.org>; Mon,  6 Oct 2025 15:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759766256; cv=none; b=gYHh5fK+dEdETE0A+oL6UKCIeVl4wlQvoP9vPLFzx4bgaYFk4D8e3QtWmWmyGMqr05m0hQuTi4saQ40Z00YWocpsolWazvsqPK4f4oA4XXMiwJFniqq2YP8Ykk7boh/1kgheqTWCPG41liy++lD3KYIsxm8UEk4M3GEbFY0Bje0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759766256; c=relaxed/simple;
	bh=wzSI+3YV5h043Yiw4KDOsFqmPFSpeSzfbDx3HQrwZTw=;
	h=Content-Type:From:To:Subject:Message-ID:Date:MIME-Version; b=swQVCxc2HmVgOCGgAEzklVOgDxaPGBUozqBVIIwBSGe0c2uFLzXknQBFwItQDtjMyAl8CaLI0WuOhyVcCn6pZ6CUUsrPmRK2LZ/V0B7O7cTs6/9O4dFuZRkJKPtFnlESlbMWms9kBOQmtB2zkfjcfZItmCVS9LBQdBMWGgTUCJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IiPT5VJk; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2698d47e776so40842945ad.1
        for <linux-arch@vger.kernel.org>; Mon, 06 Oct 2025 08:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759766254; x=1760371054; darn=vger.kernel.org;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :reply-to:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wzSI+3YV5h043Yiw4KDOsFqmPFSpeSzfbDx3HQrwZTw=;
        b=IiPT5VJklFWkeLW8EZJSJeIHaR7ztyGIcMCTpkZXxl9qNe3TroHIt66oGNpUbrz8+Q
         TBZP1/SyWQT7X/RGAQ3DS+1QP98WNN6letnryx3p5XUn4flb77Z6GVChOBKGCHSKicAl
         s9zdS86yyXYsVDlxs4INwhHzw75QfhQ1bJGPC8V7jvEBtp692jGfandiSVxvsuWFk6O6
         FZE9t+nJBHlq122tyN0CtErdQTl9B9g/IfYObk3TX5Bo54R32JJzC1rC9M9pCDMNcS9S
         2jCnTkyo5qzWKeAq4FnG5LhJk/aQQmqK58yrgS8WBR4eOA8rjrQnW0Lhk4X6ap8JOT4l
         hPPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759766254; x=1760371054;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :reply-to:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wzSI+3YV5h043Yiw4KDOsFqmPFSpeSzfbDx3HQrwZTw=;
        b=OZ++03dtoXsHtWtl7ooI+izZB4RGaXpuF/lh7wyKHXKUTKxnLeihLXp56Mw+4lKIbR
         eq3dt+IeGzPZjDm7pSlDX4hLaZU4JTxyTlVwrQtIwHse++576KUSMFmirljMjSStuR+z
         CBPsS6gzysVUmijU50xOqLCUYCJ1fLmGV3pmoTW6LCMbHLhHyHt9Nbq63JsK9svWv87a
         jVvldsvFZRprFfcWRtwXWrkt55G1G+0NxJT+DVvoHe8qHjQfrB+0HHVw/VBp4INVz6Dh
         MGs/aLiZM5eUfyM+HusNpOgY+ATn7cOmRDMyPoaIcuBKa5XeimskeaD3vm9XofkHdapz
         Lqsw==
X-Gm-Message-State: AOJu0Yz2TwxBrr7XjUHH5/J/Gb9y/5++Mw4q2o8/rknEkMyfmM/piRke
	r7NnllQed666eE8LxKPt2W10x41CvR+mwGu6/sZICO5+h9Jhe5vb46WBlc8FyeRl
X-Gm-Gg: ASbGncsLoeLTebBUuD5hs3ptt63RkCU8aS3VgUbvWuR08lC0YBGv+YwSYh9BfC9wh34
	fSONaJs8iVUNsKSSjAXcCZjsXkCpSLVwMrCKubVDsjKNYqxs8QCS3TAOs0InWKF9cmatJeKJYqo
	wculnkENDi4nlVDVpU9iro3aEMUZoR2Ddz3L/LHVvtn7v3hC56w18KSVowhhrzUQpjs8cLTDsQ5
	03Nsq7Hlik7UN5059EHguuyw+hAxHWLaQr2wdM3P6rMo4/9eIQR8fTwF+tJNjuTV+LIm0XmI9Qg
	VNG+44CN3rw9UbKg7wAvNrfHM079+LoOkzAo0SouooDQ+z7NYXOeYZz4WXWHu5mSpWtgsmHof1W
	OULwP78n29nS8+JrSyTEY9xmioSWK8+rtM+5oJrpDGA9l/fjpkvVNgzKD5jp6rPoLjuthRnaDiv
	fzQ+fK
X-Google-Smtp-Source: AGHT+IGtTs8sWgcMrwXXAGLToh0eO/uvsorWR3qLInKWYuy0I637dwrLm1WOTx24rZdhGXBYm2gh4Q==
X-Received: by 2002:a17:903:1a86:b0:251:2d4d:bdfa with SMTP id d9443c01a7336-28e9a5fa84amr160267725ad.20.1759766253696;
        Mon, 06 Oct 2025 08:57:33 -0700 (PDT)
Received: from [127.0.0.1] ([154.80.22.164])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1ef43fsm137794075ad.122.2025.10.06.08.57.31
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 08:57:33 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: Bryan Kyler <bowenyu59@gmail.com>
To: linux-arch@vger.kernel.org
Reply-To: chrismorgance@gmail.com
Subject: Estimating & Take-Offs
Message-ID: <6cb0774f-99da-0739-fa23-03e86d41232f@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Oct 2025 15:57:30 +0000
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hello,

We are an estimation company. We provide estimating/takeoff =
services to GC and subcontractors.

We do estimates of all types of =
construction projects.

Send me the plans for a quote if you have any job =
for us. You may ask for a sample.

Regards,
Bryan Kyler
Estimation Department
City Estimating, LLC

