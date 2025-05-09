Return-Path: <linux-arch+bounces-11877-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06075AB16F2
	for <lists+linux-arch@lfdr.de>; Fri,  9 May 2025 16:14:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B43913B21A6
	for <lists+linux-arch@lfdr.de>; Fri,  9 May 2025 14:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F7A296151;
	Fri,  9 May 2025 14:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastemail60.com header.i=@fastemail60.com header.b="cCpzI6Ed"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail.fastemail60.com (mail.fastemail60.com [102.222.20.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1099E295DA0
	for <linux-arch@vger.kernel.org>; Fri,  9 May 2025 14:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=102.222.20.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746799943; cv=none; b=W1KmgE9/8bZ+/m+6G5SR8EsNXpLJLuW5/Lh9SFENXn5efshJFJGAbYtn4bolVUBfQGiMrwxjHxxLbU8uOgtd5O6EU8Kg3OKPgp+U1xuheUhYgHn1o8MR4ZORkLD0pfUZ06x+9katQ1wfExWB8aQNzhlMlcC4Og7/Pf2lfGTVbXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746799943; c=relaxed/simple;
	bh=0kM12Ki2v7eI61I1WvQrX7nQw+DKE1uiGUA45uahRZc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ROa3k0x8CsJ+V5qokHKhH/eriCQcbaj4XNG2MnaZYPzqiNWTZTmzxqbgqqOW3ON7LvgKyvitynUtKpb0wI7Z05xMAZeRaJXwbVnXKNcCvufW2Xsixk+KQ39MpsnmbgYCHyzrN3dia6L9cO6gXtT1tWGDKORSGsCvQ1xXElWEA78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fastemail60.com; spf=none smtp.mailfrom=fastemail60.com; dkim=pass (2048-bit key) header.d=fastemail60.com header.i=@fastemail60.com header.b=cCpzI6Ed; arc=none smtp.client-ip=102.222.20.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fastemail60.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=fastemail60.com
Received: from fastemail60.com (unknown [194.156.79.202])
	by mail.fastemail60.com (Postfix) with ESMTPA id C2E1A87C09B
	for <linux-arch@vger.kernel.org>; Fri,  9 May 2025 15:55:49 +0200 (SAST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.fastemail60.com C2E1A87C09B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastemail60.com;
	s=202501; t=1746798951;
	bh=0kM12Ki2v7eI61I1WvQrX7nQw+DKE1uiGUA45uahRZc=;
	h=Reply-To:From:To:Subject:Date:From;
	b=cCpzI6Eddeiimvx3G7Su6DjNCvgUJo6gDGaSP9aF6ohk2lgczXviu/LzJLHfy5lX6
	 mb7Ch+UGh8g2dy5rG9H0ckbNtZ5MsKIeA5NZ9yRN8PYkoo74VLnlsbJnP7Z67AVYpx
	 H2SXlRNjtRiGDT2NU1aWLWs6QtYz8pQrjql9bf1jH82BKEBWN9xYfbHPkxrWhBpLd+
	 WMYaRjl0FNPH04bNi3zH+KcPvX2407pjpBMRz5tnws3lKWfvHNNDGC4mwfQaiumBEi
	 h4bXGqQBOM2oaINsdva78b6B5ebmHbp8fVS/WLnBUlF3JNJKKkyllebvYc+8hus59G
	 gO1leqf6kAO4Q==
Reply-To: import@herragontradegroup.cz
From: Philip Burchett<info@fastemail60.com>
To: linux-arch@vger.kernel.org
Subject: Inquiry
Date: 09 May 2025 09:55:49 -0400
Message-ID: <20250509095547.B3FD145159CAE975@fastemail60.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.4 (mail.fastemail60.com [0.0.0.0]); Fri, 09 May 2025 15:55:51 +0200 (SAST)

Greetings, Supplier.

Please give us your most recent catalog; we would want to order=20
from you.

I look forward to your feedback.


Philip Burchett

