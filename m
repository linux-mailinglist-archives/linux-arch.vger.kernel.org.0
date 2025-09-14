Return-Path: <linux-arch+bounces-13598-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 339F1B5669F
	for <lists+linux-arch@lfdr.de>; Sun, 14 Sep 2025 06:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFDDE202AA5
	for <lists+linux-arch@lfdr.de>; Sun, 14 Sep 2025 04:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D475A273D81;
	Sun, 14 Sep 2025 04:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OJqW6gFT"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67076270572
	for <linux-arch@vger.kernel.org>; Sun, 14 Sep 2025 04:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757823572; cv=none; b=LwXbZvFJUlbSAehLU/3XEbm/8pW3tQK8l0dd3VQy3K6MqIIeR7ktBaF/MU2xMJnqBFV/akafKhnNHU9Q7vVPCJpsacoLno5P5Ea7zJ3QodUamGXOahmGRSL2Tz6vtqj1LzdnwbPqBY6aRMXov9seXUsootnb/rSDhdhQyHfXMxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757823572; c=relaxed/simple;
	bh=nKH8BykbZ/NG2ohjRy0QYNVXxhFKK6pBLbFy0ufJ1Dk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dZ8Pb7w3X97Q1h4A8tJb9eGdurrtyZVZRlHUDyllFuclje6nOZSJSn52tjA+dcOB51Xj13s/g4JY3Xe0uRhgBxRw0BqxNIdYxOMrFwWiGb39ocFGeE9jOPYS6vB9xdeoXHkqX+5zFe3Hdg0gPVkIk6Uw2omAPodpRVZa2EBAbqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OJqW6gFT; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b04b55d5a2cso549147166b.2
        for <linux-arch@vger.kernel.org>; Sat, 13 Sep 2025 21:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757823569; x=1758428369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LXtvCmrZRR9OgP0sG11mqG9m/nOQIjqm8VdJ9uLACjc=;
        b=OJqW6gFTmxCLo302hPNut8BO+ryXGy8PIMl/uEHO+E+z8i2EI7bfQdJIzRtBRfvXw+
         kcWbRtogH1JQpYSKNv6/zC4/cphZqfgFpRGzi+biQSqIyclF5+D85pOtnPCF+2OqkZz3
         CDy5gGsVM4vK7s4rQQw8rm4UeVohzh6niXAU3IEb2SuGNO2EeuKPfgMpVtnZIsHoZjbx
         vpDwdZIfOKoR5NhKuV5Cx0QkZBDdn8VSiqtXNhrSCK1lfZzEVpu8tq07tpGEuWiSX78h
         yx8FmO3uN2ENwCxH/6hjHHYqFM9jtWMEntVkZB7EYZ3E0XE1sdusU+KrGJTN7b5oFKbe
         8fPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757823569; x=1758428369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LXtvCmrZRR9OgP0sG11mqG9m/nOQIjqm8VdJ9uLACjc=;
        b=AcpPpxng3PbxvWRIzKh7ZW8abgZNX5Izi1x0aR3aKSHpGsXc4V3UTe7y3yTHTBZoKV
         Y6MqjSJvxAfP9140u54nKK/qa6jDXz6a/763OmeWkuWsy/agpoKJqi9wC0y9jenilmW5
         OiYkb+BAwLcXWc3VVWm6XRqOZY39LXrWyhM7/UQ9ZUcD/w0cIwcWQmPKr38FtS+YvEwM
         cSMoUGydDWZp4JeP+FRWoafA/FoTQlSn7Wtdhdygqj6JKCPDWDn0zIvwMA+9Ftun0B+C
         iAjkejuWTNSYINrtQsTdn7FUCDEe/8OBtq5T92c2dxZ6ASaaO+lsGNVWZ16+YPyK9nw1
         +uPg==
X-Forwarded-Encrypted: i=1; AJvYcCUTT/LDVN/FkBMihev2sjunec43yLoTb9amlR4Mhom9zZyphZaykSKGe6hFmh7wC5mKMkuSrdj88ye4@vger.kernel.org
X-Gm-Message-State: AOJu0YwHzUqStkuILqLDaeZ/7LDi0PK8jsPxD/OnnZN6W37prn2nQcg4
	M5Zt5Vh2vMaENX1+JqLLo5MEPCF+sJ3Nbnudcuy6OQsv8tA8aeJYQGy6
X-Gm-Gg: ASbGnct994c8pVmYzmVj/XGLLiWeTUwqm6oDttwBkdLrsBOQ/fstSdq27GAASldqSoA
	Gb3bV26S2yiJ1ucBiaaU1cXzGzWpr0uefmVwyUuimPeuvp7yQaFElZGFjY6tQupDP1wCUhStrTV
	B76os0bus6wZQ7dNwaJ6tXhk8gTASDcviLJA3oOkW6K1PkiSQswqk3Vlh5q5id34dX0T7GdspiO
	9faprFERvEO81La3jsOyy8+odKrUAPZwpj12TB5bpWXN0qvKAp1UjERFAHNdWeQqKEBjoO+eJBV
	IAbU/VefP2LG6dpoBXgy1tWkd6F1TN1mM2D9lNZdI9rVpRR9m3E8TVtoPn7OMQEGmQOR5XZ+9b7
	ysu1ItLYjEYJ10EgAPZ1gF5lLDEplNA==
X-Google-Smtp-Source: AGHT+IF6mujdx9qWAhF6oXDc9ZfcQYBKEdRbKR8jum+cm7upWvg9UYWarRjAWufJtq6SFHzRS8+jpA==
X-Received: by 2002:a17:907:9809:b0:b04:25e6:2ddc with SMTP id a640c23a62f3a-b07c353a723mr763099266b.8.1757823568595;
        Sat, 13 Sep 2025 21:19:28 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b07c28f190fsm504796666b.39.2025.09.13.21.19.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Sep 2025 21:19:28 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: safinaskar@gmail.com
Cc: akpm@linux-foundation.org,
	andy.shevchenko@gmail.com,
	axboe@kernel.dk,
	brauner@kernel.org,
	cyphar@cyphar.com,
	devicetree@vger.kernel.org,
	ecurtin@redhat.com,
	email2tema@gmail.com,
	graf@amazon.com,
	gregkh@linuxfoundation.org,
	hca@linux.ibm.com,
	hch@lst.de,
	hsiangkao@linux.alibaba.com,
	initramfs@vger.kernel.org,
	jack@suse.cz,
	julian.stecklina@cyberus-technology.de,
	kees@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-alpha@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-block@vger.kernel.org,
	linux-csky@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-um@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	loongarch@lists.linux.dev,
	mcgrof@kernel.org,
	mingo@redhat.com,
	monstr@monstr.eu,
	mzxreary@0pointer.de,
	patches@lists.linux.dev,
	rob@landley.net,
	sparclinux@vger.kernel.org,
	thomas.weissschuh@linutronix.de,
	thorsten.blum@linux.dev,
	torvalds@linux-foundation.org,
	tytso@mit.edu,
	viro@zeniv.linux.org.uk,
	x86@kernel.org
Subject: Re: [PATCH RESEND 00/62] initrd: remove classic initrd support
Date: Sun, 14 Sep 2025 07:19:23 +0300
Message-ID: <20250914041923.4119219-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250913003842.41944-1-safinaskar@gmail.com>
References: <20250913003842.41944-1-safinaskar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Gmail banned me after first bunch of letters.
Just now I sent remaining letters.
So now the patchset is ready for review

-- 
Askar Safin

