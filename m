Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB97030FEC2
	for <lists+linux-arch@lfdr.de>; Thu,  4 Feb 2021 21:49:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbhBDUrZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 4 Feb 2021 15:47:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbhBDUrX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 4 Feb 2021 15:47:23 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 065DFC0613D6;
        Thu,  4 Feb 2021 12:46:41 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id m22so6621840lfg.5;
        Thu, 04 Feb 2021 12:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3fSrYxUXmlBaB+2NXWGl7tEc3+t2JcOM6NbRWxINsXA=;
        b=E5L8mx2TZxzo7nyiCm8lezIbPoDAbvkz1PckVfaH/u1Mu+Q5TQfbEgPftlNj+Z4Z90
         BvexiDRA75M3TXXeiUoQJxOAIDOlD5umJkLm92wGmWwAkHekez0bDy5vtSyyIy1okHm7
         MmVy9TTvOCjUbMU/4lHlfxVHFIxC2okBF3e6xo4QozIw0Eyh4udmJudDRKHNvWRGFRRf
         0VHGewJPxMLv0sjAfZNJ53BNSjex5br4lRaOZ+fetxtN/MImxZfO6+J4u2rV+nJ3tihx
         Oite0B9bGX+BeiFQ9/6wpR0qnyaZ7dRZOkbC2FCk78C33GNvq8WNJuBKEUd6DqtikioA
         aUlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3fSrYxUXmlBaB+2NXWGl7tEc3+t2JcOM6NbRWxINsXA=;
        b=DPHN6mKcJPR6u7y/nhzynderLJuF+z0sO35vVs1HypV1+FQGfELtOtM7P/61fXPQh1
         H3nTCwlwi4mmACgxKb2+KdtOVj6j3Atcb57xneIq/2XfQ80u13f8mnSwDwbHI6d0y/0h
         SjxCFK2v4OC9dHO6mteQ1DV5LN9YVdC0ZLYcdZN+upxv/Nkx/x+xJyhFLKHsws+YDH1e
         CwAaEluYp5aEKgNKiTk1GSMczO482au1VyHX8XFzTVyiuRGFzO9+abdleuhC/M0VTP2f
         90XaZEMamlKcvf9O9K6LbsaIaHCYfoihMok3eggjCjpWTLu2hkpt1FpOvp7gDmorinlk
         0Ezg==
X-Gm-Message-State: AOAM532jzIKKtQDlKEUdvTD4FIMiBMKXqLggVtykgJ/n5JJlcUGBANIN
        E0OfpCnW0wYyT3k6OfXbsxs=
X-Google-Smtp-Source: ABdhPJxLQ8Fe8SBO4JjytedIKGgsbxx/sY199uRRk+DUm6B/HVymjVfU9EKXw5MgrZ59/eUPJ+TVWg==
X-Received: by 2002:ac2:592b:: with SMTP id v11mr606993lfi.512.1612471598856;
        Thu, 04 Feb 2021 12:46:38 -0800 (PST)
Received: from grain.localdomain ([5.18.103.226])
        by smtp.gmail.com with ESMTPSA id d23sm784872ljo.17.2021.02.04.12.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 12:46:37 -0800 (PST)
Received: by grain.localdomain (Postfix, from userid 1000)
        id 6A112560087; Thu,  4 Feb 2021 23:46:36 +0300 (MSK)
Date:   Thu, 4 Feb 2021 23:46:36 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>
Subject: Re: [PATCH v19 12/25] mm: Introduce VM_SHSTK for shadow stack memory
Message-ID: <20210204204636.GH2172@grain>
References: <20210203225547.32221-1-yu-cheng.yu@intel.com>
 <20210203225547.32221-13-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210203225547.32221-13-yu-cheng.yu@intel.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 03, 2021 at 02:55:34PM -0800, Yu-cheng Yu wrote:
>  
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 602e3a52884d..59623dcd92bb 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -661,6 +661,9 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
>  		[ilog2(VM_PKEY_BIT4)]	= "",
>  #endif
>  #endif /* CONFIG_ARCH_HAS_PKEYS */
> +#ifdef CONFIG_X86_CET
> +		[ilog2(VM_SHSTK)]	= "ss",
> +#endif
>  	};

IIRC we've these abbreviations explained in documentaion
(proc.rst file). Could you please update it once time
permit? I think it can be done on top of the series.
