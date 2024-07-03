Return-Path: <linux-arch+bounces-5235-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39FA092577B
	for <lists+linux-arch@lfdr.de>; Wed,  3 Jul 2024 11:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8CAB288F7B
	for <lists+linux-arch@lfdr.de>; Wed,  3 Jul 2024 09:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42BAD155335;
	Wed,  3 Jul 2024 09:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="VF3Uyut2"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C616143758;
	Wed,  3 Jul 2024 09:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720000539; cv=none; b=QoLLjhyhcNzH5UWlepdZH4KJPWZq9Hp06HVP9K6S21UIkZlyT8PNM/PZMzqOkEIu/k7swPvzQbqLlrV0KCHIDk4u/1NlB5f3+oNI+h83i5hTDY19WY+NTsxMiygH1OSsgJkfTGV9Ar5PYKonIw8LTDsQOuRKlCvsgHHZtrMNitI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720000539; c=relaxed/simple;
	bh=VAztpCOR1tH3GwIz0d5tqw3J6dkGZ3sS7qwDIFUKl/U=;
	h=MIME-Version:Content-Type:Date:Message-ID:To:CC:Subject:From:
	 References:In-Reply-To; b=jNF7IC0nhC0LyVtYCWFXX1J70++MEvNiw2GfDHFm7Hu1cvqn59QDyk4px3IKxa+N+9n2Y30MxNJc4LqqcvHM9yXgaGgudG5/YR93zl28z3r5BFIMOv/OsG2tUZclKGwy6XmleNYkUXLe8273YI8QV9OcADq0lk9FgHit21VN39c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.es; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=VF3Uyut2; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.es
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1720000538; x=1751536538;
  h=mime-version:content-transfer-encoding:date:message-id:
   to:cc:subject:from:references:in-reply-to;
  bh=VAztpCOR1tH3GwIz0d5tqw3J6dkGZ3sS7qwDIFUKl/U=;
  b=VF3Uyut2JB5TiKqzMmDJ71r78jkF5eqbmYhcisPNoGEP1s7swEEmQsIr
   FGtjXE5EK1+O4E7C2grr0XnHuKkYFg4MleaM1yvm3rp0VaWPY4cefExOP
   5sVNDs+f/jkH4omBB99/mQ3Rr6rkkPjmReFWa74uVeESsxllNw0gHnGgd
   o=;
X-IronPort-AV: E=Sophos;i="6.09,181,1716249600"; 
   d="scan'208";a="643328494"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 09:55:35 +0000
Received: from EX19MTAEUC001.ant.amazon.com [10.0.17.79:41563]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.31.218:2525] with esmtp (Farcaster)
 id 4054678a-94ee-40f8-a85c-6afac11b8361; Wed, 3 Jul 2024 09:55:34 +0000 (UTC)
X-Farcaster-Flow-ID: 4054678a-94ee-40f8-a85c-6afac11b8361
Received: from EX19D004EUC001.ant.amazon.com (10.252.51.190) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 3 Jul 2024 09:55:34 +0000
Received: from localhost (10.13.235.138) by EX19D004EUC001.ant.amazon.com
 (10.252.51.190) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34; Wed, 3 Jul 2024
 09:55:27 +0000
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 3 Jul 2024 09:55:24 +0000
Message-ID: <D2FTASL4CXLN.32GYJ8QZH4OCR@amazon.com>
To: <seanjc@google.com>
CC: <pbonzini@redhat.com>, <seanjc@google.com>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>, <vkuznets@redhat.com>,
	<linux-doc@vger.kernel.org>, <linux-hyperv@vger.kernel.org>,
	<linux-arch@vger.kernel.org>, <nsaenz@amazon.com>,
	<linux-trace-kernel@vger.kernel.org>, <graf@amazon.de>,
	<dwmw2@infradead.org>, <pdurrant@amazon.co.uk>, <mlevitsk@redhat.com>,
	<jgowans@amazon.com>, <corbet@lwn.net>, <decui@microsoft.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <amoorthy@google.com>
Subject: Re: [PATCH 00/18] Introducing Core Building Blocks for Hyper-V VSM
 Emulation
From: Nicolas Saenz Julienne <nsaenz@amazon.com>
X-Mailer: aerc 0.17.0-152-g73bcb4661460-dirty
References: <20240609154945.55332-1-nsaenz@amazon.com>
In-Reply-To: <20240609154945.55332-1-nsaenz@amazon.com>
X-ClientProxiedBy: EX19D039UWB002.ant.amazon.com (10.13.138.79) To
 EX19D004EUC001.ant.amazon.com (10.252.51.190)

Hi Sean,

On Sun Jun 9, 2024 at 3:49 PM UTC, Nicolas Saenz Julienne wrote:
> This series introduces core KVM functionality necessary to emulate Hyper-=
V's
> Virtual Secure Mode in a Virtual Machine Monitor (VMM).

Just wanted to make sure the series is in your radar.

Thanks,
Nicolas

