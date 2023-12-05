Return-Path: <linux-arch+bounces-690-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30CAE804EB1
	for <lists+linux-arch@lfdr.de>; Tue,  5 Dec 2023 10:51:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7219B2816A4
	for <lists+linux-arch@lfdr.de>; Tue,  5 Dec 2023 09:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC0F495F7;
	Tue,  5 Dec 2023 09:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H2CBKRaD"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43CFEA7
	for <linux-arch@vger.kernel.org>; Tue,  5 Dec 2023 01:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701769908;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7dVZSK5HrOSlXE62GRvm87IDdzGVk4JEDjk3rU5ubq8=;
	b=H2CBKRaD7IU7VM7s20/zAkJ1AIKeNfe3e2TIWwfhjumjajscddCTzU1QnCCxCjUKubdeH3
	hOkwwcLFO9j1Z7z5A84mZbnc3TsnzIXDS+Q841jKHNUw0MDNiovZHBMF2ViwhxWcRiYYv5
	eUn6zkNi67Q5o8nOqp02vkQJgcOBDek=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-582-F4k2HGFBPB6w4DHHBWvnrw-1; Tue,
 05 Dec 2023 04:51:43 -0500
X-MC-Unique: F4k2HGFBPB6w4DHHBWvnrw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3E0002806040;
	Tue,  5 Dec 2023 09:51:43 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.39.192.84])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D4BCF1C060AF;
	Tue,  5 Dec 2023 09:51:41 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: akpm@linux-foundation.org,  linux-kernel@vger.kernel.org,
  linux-arch@vger.kernel.org,  linux-api@vger.kernel.org,  x86@kernel.org
Subject: Re: [PATCH] ELF: supply userspace with available page shifts
 (AT_PAGE_SHIFT_LIST)
References: <6b399b86-a478-48b0-92a1-25240a8ede54@p183>
Date: Tue, 05 Dec 2023 10:51:39 +0100
In-Reply-To: <6b399b86-a478-48b0-92a1-25240a8ede54@p183> (Alexey Dobriyan's
	message of "Mon, 4 Dec 2023 20:18:48 +0300")
Message-ID: <87v89dvuxg.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

* Alexey Dobriyan:

> +/*
> + * Page sizes available for mmap(2) encoded as 1 page shift per byte in
> + * increasing order.
> + *
> + * Thus 32-bit systems get 4 shifts, 64-bit systems get 8 shifts tops.

Couldn't you use the bits in a long instead, to indicate which shifts
are present?  That's always going to be enough.

Thanks,
Florian


