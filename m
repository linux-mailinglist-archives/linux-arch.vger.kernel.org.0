Return-Path: <linux-arch+bounces-2338-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ADC7854417
	for <lists+linux-arch@lfdr.de>; Wed, 14 Feb 2024 09:35:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DD2F1C26B19
	for <lists+linux-arch@lfdr.de>; Wed, 14 Feb 2024 08:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF04D12B6D;
	Wed, 14 Feb 2024 08:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vexlyvector.com header.i=@vexlyvector.com header.b="bXHS9cfJ"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail.vexlyvector.com (mail.vexlyvector.com [141.95.160.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB51612B6A
	for <linux-arch@vger.kernel.org>; Wed, 14 Feb 2024 08:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.95.160.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707899738; cv=none; b=fYHA+nsuVmvzrYzUfNueiAB8BHTesPDRjHf7gmU7F84oCBqRcZFNTCcFDQhh56mPV/c5JB2X+B6BRuyR7aqWgmKykCsd+E0h+YsmCACy667O+f+976BQ+knxwNbKIFomsIVleCnkULE8yHK/T+7k61wCk5ESeYizLX2PPmWwSo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707899738; c=relaxed/simple;
	bh=waaYxUsyRtmB2zEBuWcqRuRHSoYd8sJFCtgHO/3AHKE=;
	h=Message-ID:Date:From:To:Subject:MIME-Version:Content-Type; b=qGT7EcNsZjopv0nDVvacqL3J/wEYLDYQCAmKK8owImfZx8jIXjMszhnUP7WFavO3ySgA2+au+5zvDRUeokPVkapTCi5/LgoG6sCjboI9QsO1CLRubqY0PtcNukpVOZ3ymkSVpx8Oh7rUkS0Kx6jJ3GaED5ngEvUF1illM05EAOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vexlyvector.com; spf=pass smtp.mailfrom=vexlyvector.com; dkim=pass (2048-bit key) header.d=vexlyvector.com header.i=@vexlyvector.com header.b=bXHS9cfJ; arc=none smtp.client-ip=141.95.160.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vexlyvector.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vexlyvector.com
Received: by mail.vexlyvector.com (Postfix, from userid 1002)
	id E479DA2E0F; Wed, 14 Feb 2024 08:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=vexlyvector.com;
	s=mail; t=1707899725;
	bh=waaYxUsyRtmB2zEBuWcqRuRHSoYd8sJFCtgHO/3AHKE=;
	h=Date:From:To:Subject:From;
	b=bXHS9cfJkhgyDhH+61VMguQ9n3IQCwK9YdGG3OH5gRfUMp2QWB2MP0QCgkNvCTPlA
	 OXtR6Qczhqus9KjHz1Wz42yLlRKppVF5L8qe13PJSZ0+IpTal3RWMrzjX5A07fIrrK
	 G9EoR9TG4bDugGVMnO8z78KdYWIIEajmH9rS7QJ8pw4nIABcIH+odNg8c5oNCVz1QZ
	 n+5HhXboNKAh3JuPQTGQALZPtD3VNNE1oqejgT0wDuGGMrS+XgKSvm/FWUmJ8Jk2vF
	 HLHGKAjzMjfbECMADwAbPX4Gnbzd9ALb8yzbDcQwK5ChazEAePyhCsBAEmYbY9rhut
	 EK1pVnfDUxClw==
Received: by mail.vexlyvector.com for <linux-arch@vger.kernel.org>; Wed, 14 Feb 2024 08:35:23 GMT
Message-ID: <20240214074500-0.1.c0.q1aq.0.016ooe83p2@vexlyvector.com>
Date: Wed, 14 Feb 2024 08:35:23 GMT
From: "Ray Galt" <ray.galt@vexlyvector.com>
To: <linux-arch@vger.kernel.org>
Subject: Meeting with the Development Team
X-Mailer: mail.vexlyvector.com
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

I would like to reach out to the decision-maker in the IT environment wit=
hin your company.

We are a well-established digital agency in the European market. Our solu=
tions eliminate the need to build and maintain in-house IT and programmin=
g departments, hire interface designers, or employ user experience specia=
lists.

We take responsibility for IT functions while simultaneously reducing the=
 costs of maintenance. We provide support that ensures access to high-qua=
lity specialists and continuous maintenance of efficient hardware and sof=
tware infrastructure.

Companies that thrive are those that leverage market opportunities faster=
 than their competitors. Guided by this principle, we support gaining a c=
ompetitive advantage by providing comprehensive IT support.

May I present what we can do for you?


Best regards
Ray Galt

