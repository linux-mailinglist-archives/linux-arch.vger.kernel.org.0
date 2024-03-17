Return-Path: <linux-arch+bounces-3015-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F3287DF0B
	for <lists+linux-arch@lfdr.de>; Sun, 17 Mar 2024 18:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E1291F21815
	for <lists+linux-arch@lfdr.de>; Sun, 17 Mar 2024 17:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E3A1CD3F;
	Sun, 17 Mar 2024 17:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CErTCt+h"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B551CD3C;
	Sun, 17 Mar 2024 17:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710697681; cv=none; b=mUBl/GrCLWCQTcm/tPRaoKY8GW9a5/v9Ua/Z3PD4tlJsuewGuKiJjhoMwhqF9fe6bzY4tuzD5PHfariBFIU84opiW9MuvkPit+RB4ChH7o53hicXgzMmnke9dh6AtKcKA/v04MghYGB2U45I7jjh2SSpjUtkF+oezuhUeMXvahU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710697681; c=relaxed/simple;
	bh=iFgr+b97KAvPfCR6ghGNye2kCkDZc+J9IWrRuv7n9io=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To; b=Vh/R2Ki3QE9JVabIEWPEUayZ1Vu58t3/Nms0AxSkSZu307++WB2Q4IyG9A9Ndz96ZO10lfoBi1it/44R/8WgqZHyVbtpxuKllCw7cED8Orus9gh7LmzPNWZ1mKR6lZ8iHvG5y4niFe5D136N8S/nc9POcti7Pno6iHHVNwHNE1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CErTCt+h; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3c37970b52aso1472491b6e.0;
        Sun, 17 Mar 2024 10:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710697678; x=1711302478; darn=vger.kernel.org;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=/nUQ6ib1+zRvwxKYZbx2Zz20+PnydyUeEfxBg3tXRtk=;
        b=CErTCt+hFtHB4HKizyA9CHMXN6cONeSohumsxv8EumhoK24/jESl1f2u15CMZcckn+
         S0NUePM9tGz3kgAJlFPBtUpNuPjqGGwRb1HP//C4j1gLze5V5jRk80RXPFb1ZhGr637f
         lpL6WNwfUGbeOczo4zXFnkpXKPc78Gjqs/TK/K5Hq66xhmFSCcgQ/JTKhB/OyXk3s3cN
         2dncy84c7fbILGSLNXNETPGEkx9fWbK6ef28Er2yBGvK75BxcWsrmLvu3O89Gk+6vpIa
         4Wf6Bj03HPXWcg4kpmgfiRzyt63VGw9F6qWUJoNVi/aQI6Ybbubyfeuw/UbhDglz4DDU
         EYZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710697678; x=1711302478;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/nUQ6ib1+zRvwxKYZbx2Zz20+PnydyUeEfxBg3tXRtk=;
        b=LO11AQlWJh4+wZ1lEdjWxW1GRez1UWDgz9RrGWSlFfJPDTt0wJGJKRjrgbAt9Wm7so
         SCgjaqLTmJ2tqA/m+kasiUQ2cnL4XcSZDSpDoZ3cwv+WumF3mztXFObgvROc3w94XSQO
         GXYVL/b88s4bhSCHOn5jaMIx0GwejGKyPq/+oB0yn+/wJoBQnvnPqCr8dw+btGZewI0i
         Fn4HZ+2kTkZYpVSVWp5UbVeJjZMTvw0rxsJUd7Ujmt/51KJozVd1iGwHGPgWK+BjGmqM
         D/aO6XGuVmbCI6zmWBoo8JGzJlHKcG5i5TCl9rhXGe8pek4qhQfqE6KdBHlIJ9M9peJc
         xZ2A==
X-Forwarded-Encrypted: i=1; AJvYcCXRBTJ4rzJqdssCthT/cUby4k14kt9DZaTakjPqa2MxadJJSgMzmwDXYQOkZ3avnjn8vJA0bUOqXmGl0i07W1W/rUSRbZRJhp7WOeJ160v8jCUXw2sOrSwTxSjO9W4/qA==
X-Gm-Message-State: AOJu0YwJYCwMkZxfuDrdcQOKS7GUVWiFEl2dzfFsPNx+pxyoFP4QV0o3
	q8krcDHz+Ng5PWjV4pvZzIU3Owsbvh4BBjPQsU4+87zL1PqVfxOyShbPbbgeMNQ=
X-Google-Smtp-Source: AGHT+IETYmdnuS52fXG2/Dt89v96pDkvRPSM6OlcsJ60BUTDT3kxBHZ0IX7t3LA+Shx4xVHhF0jpJg==
X-Received: by 2002:a05:6871:60e:b0:220:be2c:6083 with SMTP id w14-20020a056871060e00b00220be2c6083mr12261987oan.49.1710697678171;
        Sun, 17 Mar 2024 10:47:58 -0700 (PDT)
Received: from smtpclient.apple ([2402:d0c0:11:86::1])
        by smtp.gmail.com with ESMTPSA id u22-20020a62d456000000b006e6c10fc87fsm6730122pfl.46.2024.03.17.10.47.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Mar 2024 10:47:57 -0700 (PDT)
From: Alan Huang <mmpgouride@gmail.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.300.61.1.2\))
Subject: Question about ISA2+pooncelock+pooncelock+pombonce litmus
Message-Id: <12E5C279-ADB1-463E-83E2-0A4F5D193754@gmail.com>
Date: Mon, 18 Mar 2024 01:47:43 +0800
To: linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org,
 rcu@vger.kernel.org
X-Mailer: Apple Mail (2.3774.300.61.1.2)

Hi,

I=E2=80=99m playing with the LKMM, then I saw the =
ISA2+pooncelock+pooncelock+pombonce.

The original litmus is as follows:
------------------------------------------------------
P0(int *x, int *y, spinlock_t *mylock)
{
	spin_lock(mylock);
	WRITE_ONCE(*x, 1);
	WRITE_ONCE(*y, 1);
	spin_unlock(mylock);
}

P1(int *y, int *z, spinlock_t *mylock)
{
	int r0;

	spin_lock(mylock);
	r0 =3D READ_ONCE(*y);
	WRITE_ONCE(*z, 1);
	spin_unlock(mylock);
}

P2(int *x, int *z)
{
	int r1;
	int r2;

	r2 =3D READ_ONCE(*z);
	smp_mb();
	r1 =3D READ_ONCE(*x);
}

exists (1:r0=3D1 /\ 2:r2=3D1 /\ 2:r1=3D0)
------------------------------------------------------
Of course, the result is Never.=20

But when I delete P0=E2=80=99s spin_lock and P1=E2=80=99s spin_unlock:
-------------------------------------------------------
P0(int *x, int *y, spinlock_t *mylock)
{
	WRITE_ONCE(*x, 1);
	WRITE_ONCE(*y, 1);
	spin_unlock(mylock);
}

P1(int *y, int *z, spinlock_t *mylock)
{
	int r0;

	spin_lock(mylock);
	r0 =3D READ_ONCE(*y);
	WRITE_ONCE(*z, 1);
}

P2(int *x, int *z)
{
	int r1;
	int r2;

	r2 =3D READ_ONCE(*z);
	smp_mb();
	r1 =3D READ_ONCE(*x);
}

exists (1:r0=3D1 /\ 2:r2=3D1 /\ 2:r1=3D0)
------------------------------------------------------
Then herd told me the result is Sometimes.

Is this expected?=20


