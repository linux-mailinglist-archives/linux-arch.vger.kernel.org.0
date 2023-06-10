Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D36C72AEED
	for <lists+linux-arch@lfdr.de>; Sat, 10 Jun 2023 23:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjFJVKG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 10 Jun 2023 17:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjFJVKF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 10 Jun 2023 17:10:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A483584;
        Sat, 10 Jun 2023 14:10:04 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686431402;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OrTOePfREEciLtXfuUl8hDBbpqxfuVX9i8krldtKOAY=;
        b=mIxLEuMfpk7GLDEgCpK9RyCRztksQ2KR3hAfMuUhrBxRYYleSd5DnOtm7ueortcishYe19
        1S3NCaeWweymMMTeajLKGDRPfP6A7h+cWuuhPVjqs7xab9LdbEqCXXM9RS68w8R9XqB9BZ
        4PIW8qLbXp5ciqzVsEtE8EjSTrCKdENU4gb1cv+to6rZdVsEOkMBGKWAnh98pBszQtxgnU
        8lDkey+xZts7l6QsZXD7ia8QVzlPSzO5t8Y2MCiAUCK2vDl0fvFbTRyc46SewJAEaTFzZn
        nix/DX0ipblz/7S2xlwnlD01kFvYdf0DBWi6eAE0b/adb7YBwsNvqK4ZKPcZYw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686431402;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OrTOePfREEciLtXfuUl8hDBbpqxfuVX9i8krldtKOAY=;
        b=euWjH8gK9tkmFZKPMC2SdGkEjWDHeY4U+j35rBJnG7zt2xQX5s8P3nel+NXuc2olh8obYc
        hsPx70kBtP45khAg==
To:     Laurent Dufour <ldufour@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, x86@kernel.org,
        dave.hansen@linux.intel.com, mingo@redhat.com, bp@alien8.de,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 8/9] powerpc: Add HOTPLUG_SMT support
In-Reply-To: <6e86aedb-9349-afd4-0bcb-1949e828f997@linux.ibm.com>
References: <20230524155630.794584-1-mpe@ellerman.id.au>
 <20230524155630.794584-8-mpe@ellerman.id.au>
 <5752a488-be54-61a0-6d18-647456abc4ee@linux.ibm.com>
 <6e86aedb-9349-afd4-0bcb-1949e828f997@linux.ibm.com>
Date:   Sat, 10 Jun 2023 23:10:02 +0200
Message-ID: <87h6rf81n9.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jun 01 2023 at 18:19, Laurent Dufour wrote:
> @@ -435,12 +435,17 @@ void __init cpu_smt_disable(bool force)
>   * The decision whether SMT is supported can only be done after the full
>   * CPU identification. Called from architecture code.
>   */
> -void __init cpu_smt_check_topology(unsigned int num_threads)
> +void __init cpu_smt_check_topology(unsigned int num_threads,
> +				   unsigned int max_threads)
>  {
>  	if (!topology_smt_supported())
>  		cpu_smt_control = CPU_SMT_NOT_SUPPORTED;
>  
> -	cpu_smt_max_threads = num_threads;
> +	cpu_smt_max_threads = max_threads;
> +
> +	WARN_ON(num_threads > max_threads);
> +	if (num_threads > max_threads)
> +		num_threads = max_threads;

This does not work. The call site does:

> +	cpu_smt_check_topology(smt_enabled_at_boot, threads_per_core);

smt_enabled_at_boot is 0 when 'smt-enabled=off', which is not what the
hotplug core expects. If SMT is disabled it brings up the primary
thread, which means cpu_smt_num_threads = 1.

This needs more thoughts to avoid a completely inconsistent duct tape
mess.

Btw, the command line parser and the variable smt_enabled_at_boot being
type int allow negative number of threads too... Maybe not what you want.

Thanks,

        tglx




