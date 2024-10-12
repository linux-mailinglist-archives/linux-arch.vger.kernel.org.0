Return-Path: <linux-arch+bounces-8060-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7806699B735
	for <lists+linux-arch@lfdr.de>; Sat, 12 Oct 2024 23:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8DA21C20DCA
	for <lists+linux-arch@lfdr.de>; Sat, 12 Oct 2024 21:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4199014D6ED;
	Sat, 12 Oct 2024 21:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RuwhezJk"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com [209.85.215.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5022564
	for <linux-arch@vger.kernel.org>; Sat, 12 Oct 2024 21:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728770321; cv=none; b=ZShm001aeUcneVCrcaY04dGIdUK51Ll7D874CqpV0QeQn+IMpEkUBlbWeABc1+yea0uzaU2sHYht09iQSD6vLIx84ORbYCe+znB+8YAN3/NvwtenVeM36zIaECLWmP/DBKUX+XEHuNCq8KVoQK+ByUWieoPGdKRsQN0c6X2RWck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728770321; c=relaxed/simple;
	bh=4p9zMCHyTvIHqWb+RiLLmYJIcUZSBcLyXxn110UCViQ=;
	h=From:Message-ID:To:Subject:Date:MIME-Version:Content-Type; b=f5vZAOJeNb5mA5v2Mq1HvTCAIS9jvbgeq8AvFW4PjAkzTdCyqHILUdQ623iGHHQTzfnkfkSFNsz+qr7hEkyhMJz/hogBRltLITOaANcBGRIiF1MxggEB1BidarEwwp2/bwJK8HZUtVivT+6fiCY8qe7BLn1GxJA2a8ovFKrB7gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RuwhezJk; arc=none smtp.client-ip=209.85.215.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f195.google.com with SMTP id 41be03b00d2f7-7e9e38dd5f1so2508835a12.0
        for <linux-arch@vger.kernel.org>; Sat, 12 Oct 2024 14:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728770319; x=1729375119; darn=vger.kernel.org;
        h=mime-version:date:subject:to:reply-to:message-id:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4p9zMCHyTvIHqWb+RiLLmYJIcUZSBcLyXxn110UCViQ=;
        b=RuwhezJkflXQ+2ch/7V1j+Rj58+r9JoYIbNbbZ2VyXQocix8XMLkIXa2Cb9frzQTKj
         SNWbaoGn+x9zn9NobWa0vdXX7myNnUrLWsASoOCIEyg3HZkJTib8ElIGDYqL3OrLvG9H
         EnlaQAaWzb7PwAhnU4LftZPRlEqTJAhda3o7LGFDJVHIMUcvI4LXYnyy3rHPvtuS6TVa
         uBqfTxUOXlF37fIDPo1tZYIXp9K6V/3qg04H86fwb+xeeW+8xBM20ItHucKFyVZy6Zk0
         JPSZHv4Xk3+Pg7AhU+x9/K/OIGhMgl1wQv7Ky3KYvpteuVvsdGTtPnhBsKFQ/n85zbnN
         v7hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728770319; x=1729375119;
        h=mime-version:date:subject:to:reply-to:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4p9zMCHyTvIHqWb+RiLLmYJIcUZSBcLyXxn110UCViQ=;
        b=ig5ssDtintSxNomTUW/i17DKaLRMZ067hufYXB+dWNsAIu+GHcFTRHYTD6R7jwqEQN
         Fd0TMrUq7Jw1qJpwujq5MCIFut94Xh4m2PpGqdJihy2haS3HhMrOogyzxQ1n/deOxlhM
         P8W8GAsoYjlj+kCu7onxQXaWRILG9ruhMhBHBkg2QCMjOp63Icemy55mfAmfLgczP4On
         EC8sKrKtgMkjcdons/7e43kXov3q4cQrHoxvLd4QhqUqvcLWICwIXToJ6QU2IQ3YPLr5
         HmJdcAzpxCah8WvvGWjgUVFPHP5D5lcCKwy7NNVagae4QjlqlbbxVBul1JfcmqRcFSvo
         NXvw==
X-Gm-Message-State: AOJu0YwmczIPS18t3tbODg/iqLEhGlDb3obSSPcV/mcFvRiBjI47Jupf
	o4dfHkD1kTcW+S4mkZdNKjJAxSi4UcNaFZfl+nA++JZ8f135W5nNK+2M8Hgo
X-Google-Smtp-Source: AGHT+IGWvvOBvF/hGg4bzqA3i6MMVC8e4XK6o931VwjmvJWZdJQUbnctpHuMLXKWO55EKrCJOWmx7A==
X-Received: by 2002:a17:90a:e98f:b0:2cf:fe5d:ea12 with SMTP id 98e67ed59e1d1-2e2f0adb444mr9576031a91.24.1728770318903;
        Sat, 12 Oct 2024 14:58:38 -0700 (PDT)
Received: from [103.67.163.162] ([103.67.163.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e2d5eeb024sm5510289a91.22.2024.10.12.14.58.38
        for <linux-arch@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Oct 2024 14:58:38 -0700 (PDT)
From: Josey Swihart <parsayasmin019@gmail.com>
X-Google-Original-From: Josey Swihart <joswihart@outlook.com>
Message-ID: <d5d6de0cf4a29308349b434bb837687a4881b978cc86e633dbfd25f9ce8d0de1@mx.google.com>
Reply-To: joswihart@outlook.com
To: linux-arch@vger.kernel.org
Subject: Yamaha Piano 10/12
Date: Sat, 12 Oct 2024 17:58:36 -0400
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

Hello,

I?m offering my late husband?s Yamaha piano to anyone who would truly appreciate it. If you or someone you know would be interested in receiving this instrument for free, please don?t hesitate to contact me.

Warm regards,
Josey

