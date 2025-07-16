Return-Path: <linux-arch+bounces-12800-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4890FB06FDE
	for <lists+linux-arch@lfdr.de>; Wed, 16 Jul 2025 10:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B6F27AA04E
	for <lists+linux-arch@lfdr.de>; Wed, 16 Jul 2025 08:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A82428A402;
	Wed, 16 Jul 2025 08:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qBIf+0md";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Jf2j+9VG";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qBIf+0md";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Jf2j+9VG"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7EF12877C8
	for <linux-arch@vger.kernel.org>; Wed, 16 Jul 2025 08:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752653166; cv=none; b=aqlIocbqNdKIuCF5p90Z4z4it8A4dG92fFJAbfiIbc0pcM9zEuXqgH6kS41Dfee/CDkebv9IAWYReKV1wmE9Pt0Nxtwcsfr3abK2Msud9Aw8qQsRvb+wri9ZMTGqnx4yzY9U/wB5tjp2D6IjA1C+5RAQdjHSgKzWVtDJD4IUWFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752653166; c=relaxed/simple;
	bh=M+i5cbdz/1oVhelnqNqzdcOfJ4QSB/HoFpyFa+NaWzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sNY7la2D1GYoV1mgi/5uoH4SIfhWoW4kdLNXtdqNyZOOkz7JgG/BCCzdZa0Rtb5HhNDL3C0DS8T+/+a2dW+dwNfECwUPiJ5/BXxmgy9VqcsS8bhj9H0SlPMZmsFFlK3lmge9VTMSlu5OF9WcIjH/H9hF3GafemsSpRg/NpbP3sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qBIf+0md; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Jf2j+9VG; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qBIf+0md; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Jf2j+9VG; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7330F2120A;
	Wed, 16 Jul 2025 08:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1752653156; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LU5GjAxuKZfey15OAKeI3kWYXnzC+vjIGf0oQkMQwa4=;
	b=qBIf+0mdpRNrkhn6xlr/6EVoYPSqmZK0ckbxmPEuL1evJnN5P9L41W/6vh1/cqMo9qRIw8
	twpSZ6kXe4TEBjxCL5qraDFziJKEpPwbR8RHwnkBQqm5RYwylgyC1rGXvRYodpvkx1uQA4
	7D1tLZX5GklgbI6qTxHLFo5ZOPoaUoc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1752653156;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LU5GjAxuKZfey15OAKeI3kWYXnzC+vjIGf0oQkMQwa4=;
	b=Jf2j+9VGv8UQulVMiJoTnxXTDiNl8h0DK/cKBp5ouDFaPqt8d5pX8i788UB6aL6ax1dDu0
	+t30HrMQVh2pNlDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1752653156; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LU5GjAxuKZfey15OAKeI3kWYXnzC+vjIGf0oQkMQwa4=;
	b=qBIf+0mdpRNrkhn6xlr/6EVoYPSqmZK0ckbxmPEuL1evJnN5P9L41W/6vh1/cqMo9qRIw8
	twpSZ6kXe4TEBjxCL5qraDFziJKEpPwbR8RHwnkBQqm5RYwylgyC1rGXvRYodpvkx1uQA4
	7D1tLZX5GklgbI6qTxHLFo5ZOPoaUoc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1752653156;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LU5GjAxuKZfey15OAKeI3kWYXnzC+vjIGf0oQkMQwa4=;
	b=Jf2j+9VGv8UQulVMiJoTnxXTDiNl8h0DK/cKBp5ouDFaPqt8d5pX8i788UB6aL6ax1dDu0
	+t30HrMQVh2pNlDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 464D9138D2;
	Wed, 16 Jul 2025 08:05:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WQB1DmNdd2jzDAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Wed, 16 Jul 2025 08:05:55 +0000
Date: Wed, 16 Jul 2025 10:05:53 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Anthony Yznaga <anthony.yznaga@oracle.com>
Cc: davem@davemloft.net, andreas@gaisler.com, arnd@arndb.de,
	muchun.song@linux.dev, akpm@linux-foundation.org, david@redhat.com,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
	rppt@kernel.org, surenb@google.com, mhocko@suse.com,
	linux-mm@kvack.org, sparclinux@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	alexghiti@rivosinc.com, agordeev@linux.ibm.com,
	anshuman.khandual@arm.com, christophe.leroy@csgroup.eu,
	ryan.roberts@arm.com, will@kernel.org
Subject: Re: [PATCH 0/3] drop hugetlb_free_pgd_range()
Message-ID: <aHddYU8elWhddpoP@localhost.localdomain>
References: <20250716012611.10369-1-anthony.yznaga@oracle.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716012611.10369-1-anthony.yznaga@oracle.com>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,localhost.localdomain:mid,sude.de:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -4.30

On Tue, Jul 15, 2025 at 06:26:08PM -0700, Anthony Yznaga wrote:
> For all architectures that support hugetlb except for sparc,
> hugetlb_free_pgd_range() just calls free_pgd_range(). It turns out
> the sparc implementation is essentially identical to free_pgd_range()
> and can be removed. Remove it and update free_pgtables() to treat
> hugetlb VMAs the same as others.
> 
> Anthony Yznaga (3):
>   sparc64: remove hugetlb_free_pgd_range()
>   mm: remove call to hugetlb_free_pgd_range()
>   mm: drop hugetlb_free_pgd_range()

Acked-by: Oscar Salvador <osalvador@sude.de>

Thanks!

 

-- 
Oscar Salvador
SUSE Labs

