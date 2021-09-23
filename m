Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51B32416850
	for <lists+linux-arch@lfdr.de>; Fri, 24 Sep 2021 01:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243512AbhIWXJV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Sep 2021 19:09:21 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37864 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236363AbhIWXJV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Sep 2021 19:09:21 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632438467;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RKiJ0bK6+KzdC8aHY81emb+95YF6Us7KSKw66ZyyWbI=;
        b=tFxRFRTBlgb2nhKu7clOVExR41yEZWh3IqcnwOjptLMJtecJhgfvrXH4enPNRvWYsp48HR
        nRaeVjWkOF4zc57VvXJOnZje807UdpsNoYcwQBWP0SE8otfpDxMsF1vmVe5XKjRLpW5zPk
        WgLkrcdAufkvJm/w/gXkmm7zFTP59HlfgBTrZtEv4HZwzm5d9aUu61KQD8fa0Y1Znpi8ze
        hkswfqPw0C62x/G86zoNRVHeojLxiG3/vPM7gxL/7u23sd0WfqJQFoIiBYMyVS4hwiu+Il
        lClTAGPvO7j/payQJTVU1M/RFSP3pVLIJE2pN3+xewTubUJ6/ZDqBiRNy8uP0A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632438467;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RKiJ0bK6+KzdC8aHY81emb+95YF6Us7KSKw66ZyyWbI=;
        b=kkn5nB01Kguwj7p/jOez68FbhkvZzbZpY/fVCIJgMs1DII5bRDr7fkz80YkKb2ECAC1HMz
        N53bu6JgPhQzbHAg==
To:     Sohil Mehta <sohil.mehta@intel.com>, x86@kernel.org
Cc:     Sohil Mehta <sohil.mehta@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Christian Brauner <christian@brauner.io>,
        Peter Zijlstra <peterz@infradead.org>,
        Shuah Khan <shuah@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Ashok Raj <ashok.raj@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        Zeng Guang <guang.zeng@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Randy E Witt <randy.e.witt@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Ramesh Thomas <ramesh.thomas@intel.com>,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH 05/13] x86/irq: Reserve a user IPI notification vector
In-Reply-To: <20210913200132.3396598-6-sohil.mehta@intel.com>
References: <20210913200132.3396598-1-sohil.mehta@intel.com>
 <20210913200132.3396598-6-sohil.mehta@intel.com>
Date:   Fri, 24 Sep 2021 01:07:47 +0200
Message-ID: <87fstugabg.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Sep 13 2021 at 13:01, Sohil Mehta wrote:
> A user interrupt notification vector is used on the receiver's cpu to
> identify an interrupt as a user interrupt (and not a kernel interrupt).
> Hardware uses the same notification vector to generate an IPI from a
> sender's cpu core when the SENDUIPI instruction is executed.
>
> Typically, the kernel shouldn't receive an interrupt with this vector.
> However, it is possible that the kernel might receive this vector.
>
> Scenario that can cause the spurious interrupt:
>
> Step	cpu 0 (receiver task)		cpu 1 (sender task)
> ----	---------------------		-------------------
> 1	task is running
> 2					executes SENDUIPI
> 3					IPI sent
> 4	context switched out
> 5	IPI delivered
> 	(kernel interrupt detected)
>
> A kernel interrupt can be detected, if a receiver task gets scheduled
> out after the SENDUIPI-based IPI was sent but before the IPI was
> delivered.

What happens if the SENDUIPI is issued when the target task is not on
the CPU? How is that any different from the above?

> The kernel doesn't need to do anything in this case other than receiving
> the interrupt and clearing the local APIC. The user interrupt is always
> stored in the receiver's UPID before the IPI is generated. When the
> receiver gets scheduled back the interrupt would be delivered based on
> its UPID.

So why on earth is that vector reaching the CPU at all?

> +#ifdef CONFIG_X86_USER_INTERRUPTS
> +	seq_printf(p, "%*s: ", prec, "UIS");

No point in printing that when user interrupts are not available/enabled
on the system.

> +	for_each_online_cpu(j)
> +		seq_printf(p, "%10u ", irq_stats(j)->uintr_spurious_count);
> +	seq_puts(p, "  User-interrupt spurious event\n");
>  #endif
>  	return 0;
>  }
> @@ -325,6 +331,33 @@ DEFINE_IDTENTRY_SYSVEC_SIMPLE(sysvec_kvm_posted_intr_nested_ipi)
>  }
>  #endif
>  
> +#ifdef CONFIG_X86_USER_INTERRUPTS
> +/*
> + * Handler for UINTR_NOTIFICATION_VECTOR.
> + *
> + * The notification vector is used by the cpu to detect a User Interrupt. In
> + * the typical usage, the cpu would handle this interrupt and clear the local
> + * apic.
> + *
> + * However, it is possible that the kernel might receive this vector. This can
> + * happen if the receiver thread was running when the interrupt was sent but it
> + * got scheduled out before the interrupt was delivered. The kernel doesn't
> + * need to do anything other than clearing the local APIC. A pending user
> + * interrupt is always saved in the receiver's UPID which can be referenced
> + * when the receiver gets scheduled back.
> + *
> + * If the kernel receives a storm of these, it could mean an issue with the
> + * kernel's saving and restoring of the User Interrupt MSR state; Specifically,
> + * the notification vector bits in the IA32_UINTR_MISC_MSR.

Definitely well thought out hardware that.

Thanks,

        tglx
