Return-Path: <linux-arch+bounces-12248-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8CC4ACF230
	for <lists+linux-arch@lfdr.de>; Thu,  5 Jun 2025 16:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03A65172127
	for <lists+linux-arch@lfdr.de>; Thu,  5 Jun 2025 14:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1714018CC15;
	Thu,  5 Jun 2025 14:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="dMkiogsX"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B5715747D;
	Thu,  5 Jun 2025 14:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749134389; cv=none; b=dErTnalugsfL30gLP31p89UKqYEgMSy3vlbq9SvF6TtxdKckSeHNjJczihhMeyRp35C3bZw77T8HdHfRfMBmdmZKLNlHKeQ9P0nOssPfEZ54ZRXPti+I6VoNbfTVVdEXmbvmp6MWix4U6r1ZbUskt1z7PmD7tzV0UaON+XwwW7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749134389; c=relaxed/simple;
	bh=L6aA5Viruzm2wERJh3j0+c0zu7oOACnuzqloM0reXk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jGxJl3uOuI16qaToskatba8IVtNdvuDcIDvYIT4ALJ538FqO8KmJzJsjbaInJSWru3J3ev/Snko4lOf0wc7XrlavFB1gmfKaGH87J+n7ooz+yLZGioh1RaN3MKvPKMEvzxohu2MLg/HjM7ac9jFHTtqa5tN9sPNwLhIPaN1eeJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=dMkiogsX; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=76dZEhygqEmfXO4M+UtL7RXa31FuQvFw4pYtr93FC8o=; b=dMkiogsXx/sRijvX
	p2WEvMt21radIYsASpJfvJ+7YP2XRMaVw6+cFA0HrrAC/PZYcio9fHUnq+yM+Jhe7MgLQG4+cgrsj
	Ok7NilWtZRk0F52cf9WltlUL5ATLDKNBf3VcbltxEelEeeac79JZdvKu53OoWJTGMu0eq72Kq/x2o
	pfzUjsp/VfXbYqMJcffcspeC705dbTmBvGTHZZC3qXu20ekyvM0OqoWq7AMXus32hteAL7WcQxSoU
	gbd8f6EOtxKcj8Y/UYR8JbtiAjdE+TTfau/Vn432dzfevLeAdL+OTn/wv27F/C97MrP1EbOjEvvSO
	UmQl+KR/VkKvRoLgbQ==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1uNBkr-007nEF-2s;
	Thu, 05 Jun 2025 14:39:41 +0000
Date: Thu, 5 Jun 2025 14:39:41 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Uros Bizjak <ubizjak@gmail.com>, x86@kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-bcachefs@vger.kernel.org,
	linux-arch@vger.kernel.org, netdev@vger.kernel.org,
	Nadav Amit <nadav.amit@gmail.com>, Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: Re: Large modules with 6.15 [was: [PATCH v4 6/6] percpu/x86: Enable
 strict percpu checks via named AS qualifiers]
Message-ID: <aEGsLeUWj6_wiovf@gallifrey>
References: <20250127160709.80604-1-ubizjak@gmail.com>
 <20250127160709.80604-7-ubizjak@gmail.com>
 <02c00acd-9518-4371-be2c-eb63e5d11d9c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <02c00acd-9518-4371-be2c-eb63e5d11d9c@kernel.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-34-amd64 (x86_64)
X-Uptime: 14:39:23 up 38 days, 22:52,  1 user,  load average: 0.04, 0.06, 0.02
User-Agent: Mutt/2.2.12 (2023-09-09)

* Jiri Slaby (jirislaby@kernel.org) wrote:
> On 27. 01. 25, 17:05, Uros Bizjak wrote:
> > This patch declares percpu variables in __seg_gs/__seg_fs named AS
> > and keeps them named AS qualified until they are dereferenced with
> > percpu accessor. This approach enables various compiler check
> > for cross-namespace variable assignments.
> > 
> > Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> > Acked-by: Nadav Amit <nadav.amit@gmail.com>
> > Cc: Dennis Zhou <dennis@kernel.org>
> > Cc: Tejun Heo <tj@kernel.org>
> > Cc: Christoph Lameter <cl@linux.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Ingo Molnar <mingo@kernel.org>
> > Cc: Borislav Petkov <bp@alien8.de>
> > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > Cc: Linus Torvalds <torvalds@linux-foundation.org>
> > Cc: Andy Lutomirski <luto@kernel.org>
> > Cc: Brian Gerst <brgerst@gmail.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > ---
> >   arch/x86/include/asm/percpu.h | 15 ++++++++++++---
> >   1 file changed, 12 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
> > index 27f668660abe..474d648bca9a 100644
> > --- a/arch/x86/include/asm/percpu.h
> > +++ b/arch/x86/include/asm/percpu.h
> > @@ -95,9 +95,18 @@
> >   #endif /* CONFIG_SMP */
> > -#define __my_cpu_type(var)	typeof(var) __percpu_seg_override
> > -#define __my_cpu_ptr(ptr)	(__my_cpu_type(*(ptr))*)(__force uintptr_t)(ptr)
> > -#define __my_cpu_var(var)	(*__my_cpu_ptr(&(var)))
> > +#if defined(CONFIG_USE_X86_SEG_SUPPORT) && defined(USE_TYPEOF_UNQUAL)
> > +# define __my_cpu_type(var)	typeof(var)
> > +# define __my_cpu_ptr(ptr)	(ptr)
> > +# define __my_cpu_var(var)	(var)
> > +
> > +# define __percpu_qual		__percpu_seg_override
> > +#else
> > +# define __my_cpu_type(var)	typeof(var) __percpu_seg_override
> > +# define __my_cpu_ptr(ptr)	(__my_cpu_type(*(ptr))*)(__force uintptr_t)(ptr)
> > +# define __my_cpu_var(var)	(*__my_cpu_ptr(&(var)))
> > +#endif
> > +
> 
> Another issue with this is this causes all modules in 6.15 are 2-4 times
> (compressed size) bigger:

Oh, is that why config-all kernel is too big?

Dave

> $ ll /usr/lib/modules/*-[0-9]-default/kernel/drivers/atm/atmtcp.ko.zst
> > -rw-r--r--. 1 root root 10325 May 13 11:49
> /usr/lib/modules/6.14.6-2-default/kernel/drivers/atm/atmtcp.ko.zst
> > -rw-r--r--. 1 root root 39677 Jun  2 09:13
> /usr/lib/modules/6.15.0-1-default/kernel/drivers/atm/atmtcp.ko.zst
> 
> It's due to larger .BTF section:
> .BTF              PROGBITS         0000000000000000  [-00003080-]
> [-       00000000000011a8-]  {+00003100+}
> {+       0000000000012cf8+}  0000000000000000           0     0     1
> 
> There are a lot of new BTF types defined in each module like:
> +attribute_group STRUCT
> +backing_dev_info STRUCT
> +bdi_writeback STRUCT
> +bin_attribute STRUCT
> +bio_end_io_t TYPEDEF
> +bio_list STRUCT
> +bio_set STRUCT
> +bio STRUCT
> +bio_vec STRUCT
> 
> Reverting this gives me back to normal sizes.
> 
> Any ideas?
> 
> FTR downstream report:
> https://bugzilla.suse.com/show_bug.cgi?id=1244135
> 
> thanks,
> -- 
> js
> suse labs
> 
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

