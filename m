Return-Path: <linux-arch+bounces-13745-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99456B97E6C
	for <lists+linux-arch@lfdr.de>; Wed, 24 Sep 2025 02:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 517543AF0ED
	for <lists+linux-arch@lfdr.de>; Wed, 24 Sep 2025 00:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C2F6347C7;
	Wed, 24 Sep 2025 00:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=maguitec.com.mx header.i=@maguitec.com.mx header.b="PcCaa3Zr"
X-Original-To: linux-arch@vger.kernel.org
Received: from sender4-g3-154.zohomail360.com (sender4-g3-154.zohomail360.com [136.143.188.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F060017C21E
	for <linux-arch@vger.kernel.org>; Wed, 24 Sep 2025 00:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.154
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758674080; cv=pass; b=fPCOMtWa/zAHi4kQPhPHEto6BeUMzYvJfmfzOP94eRjYDHOBIKx5Bb4Nl2S3n5YleeYwH7kqS4D+IsFOS1v+4HlAF7xj945hQqTjW4x0nH3h7VeXLYGJAl4a7ySjAOtD/+6UYOEvuTFWWEuKutZUqsxABghz8I2O9NnWxzimaas=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758674080; c=relaxed/simple;
	bh=NVtniws5AoXht+POgR4MXz+ekS/t2no6kJWeoFhBeHA=;
	h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type; b=AyestlKwm2WyVdfTQVtywz7yIPIInFGsJiGy2VxiNi71FTbae2NRPiAhmn+rSBoLge5bKX/7hb8lrA5EGPKAMK9X4hBoFyN52TvYmGVRnGNSvl5NNYEVNEn7eCaFoxVDzpewynEL11+7lDa8ZE40DMHm9PYxU19/8uqxIWFroP8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maguitec.com.mx; spf=pass smtp.mailfrom=bounce-zem.maguitec.com.mx; dkim=pass (1024-bit key) header.d=maguitec.com.mx header.i=@maguitec.com.mx header.b=PcCaa3Zr; arc=pass smtp.client-ip=136.143.188.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maguitec.com.mx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bounce-zem.maguitec.com.mx
ARC-Seal: i=1; a=rsa-sha256; t=1758674078; cv=none; 
	d=us.zohomail360.com; s=zohoarc; 
	b=HAULzEKk1TEqqv8OuKgYdz2TFERUFFYJZPG4hmWwcAmKxOSVnGqf43Kv8Fb9cWFTNrOEIjpwujMcWY2sqqE5vEfak8Ntco3MLezV8dZK+x8GttfHqZRfZfNvRnCHAGBUWlq85SklGr+5Nlg9PejEpOl4u8MD9bQJaTN5Qi0KqmQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=us.zohomail360.com; s=zohoarc; 
	t=1758674078; h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:MIME-Version:Message-ID:Reply-To:Reply-To:Subject:Subject:To:To:Message-Id:Cc; 
	bh=NVtniws5AoXht+POgR4MXz+ekS/t2no6kJWeoFhBeHA=; 
	b=GYzFmfuHpbwtitNnoecx9wkPanYSQ+kXUQleaLii4BnXnEdZVfRdVQnKd148vOxw4Fo7pum0LQ1gJbbRbmPOWCAPd0ntTPiGUh8c1B8W+EiXsF/3JODGHImybNhYCyXorIVgF7cm1e7iASU6TOJ+usfBacDlJk6Sonjt6Kpp6lQ=
ARC-Authentication-Results: i=1; mx.us.zohomail360.com;
	dkim=pass  header.i=maguitec.com.mx;
	spf=pass  smtp.mailfrom=investorrelations+9a5cb450-98d8-11f0-ace3-525400721611_vt1@bounce-zem.maguitec.com.mx;
	dmarc=pass header.from=<investorrelations@maguitec.com.mx>
Received: by mx.zohomail.com with SMTPS id 1758671653580729.3793787106755;
	Tue, 23 Sep 2025 16:54:13 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; b=PcCaa3ZrEurmRrQg2ZJyPmqe+MzdHLbgNfwl14+JW34U/HShtrkOJNaUwxze3hBaAJDOkKwnb1htIVmBXH+Ra4xq8t1xFg3yW8G8gLhhIIthi1nSWqnrqWoQajDlDgmYAao+t8HM+TYUTC9Xaxq4itlpsOnWOWSenK8Og6RO8HI=; c=relaxed/relaxed; s=15205840; d=maguitec.com.mx; v=1; bh=NVtniws5AoXht+POgR4MXz+ekS/t2no6kJWeoFhBeHA=; h=date:from:reply-to:to:message-id:subject:mime-version:content-type:content-transfer-encoding:date:from:reply-to:to:message-id:subject;
Date: Tue, 23 Sep 2025 16:54:13 -0700 (PDT)
From: Al Sayyid Sultan <investorrelations@maguitec.com.mx>
Reply-To: investorrelations@alhaitham-investment.ae
To: linux-arch@vger.kernel.org
Message-ID: <2d6f.1aedd99b146bc1ac.m1.9a5cb450-98d8-11f0-ace3-525400721611.19978ffc415@bounce-zem.maguitec.com.mx>
Subject: Thematic Funds Letter Of Intent
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
content-transfer-encoding-Orig: quoted-printable
content-type-Orig: text/plain;\r\n\tcharset="utf-8"
Original-Envelope-Id: 2d6f.1aedd99b146bc1ac.m1.9a5cb450-98d8-11f0-ace3-525400721611.19978ffc415
X-JID: 2d6f.1aedd99b146bc1ac.s1.9a5cb450-98d8-11f0-ace3-525400721611.19978ffc415
TM-MAIL-JID: 2d6f.1aedd99b146bc1ac.m1.9a5cb450-98d8-11f0-ace3-525400721611.19978ffc415
X-App-Message-ID: 2d6f.1aedd99b146bc1ac.m1.9a5cb450-98d8-11f0-ace3-525400721611.19978ffc415
X-Report-Abuse: <abuse+2d6f.1aedd99b146bc1ac.m1.9a5cb450-98d8-11f0-ace3-525400721611.19978ffc415@zeptomail.com>
X-ZohoMailClient: External

To: linux-arch@vger.kernel.org
Date: 24-09-2025
Thematic Funds Letter Of Intent

It's a pleasure to connect with you

Having been referred to your investment by my team, we would be=20
honored to review your available investment projects for onward=20
referral to my principal investors who can allocate capital for=20
the financing of it.

kindly advise at your convenience

Best Regards,

Respectfully,
Al Sayyid Sultan Yarub Al Busaidi
Director

