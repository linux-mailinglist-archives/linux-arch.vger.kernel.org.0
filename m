Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2225739AC8
	for <lists+linux-arch@lfdr.de>; Thu, 22 Jun 2023 10:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbjFVIwW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 22 Jun 2023 04:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbjFVIvm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 22 Jun 2023 04:51:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3C36213A;
        Thu, 22 Jun 2023 01:51:31 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1687423889;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=11GWicbLpC0F9A4O6rye+3TFV+Z0pKuEfGbmi5Xihgc=;
        b=Opa27WRko24s9SyCBdoBaKtro+GrTco4r1eCgge8Lgfx0shKBIsTEUSu6MG9v71RP8O3d2
        SbFwcybbw9miqtX1iK8hfGQZ6W7YN4/79DlQ24txRJ4X7h8agW+3ucdT9h2P2ItdehjhRR
        W5rLoAJs0hiIDY/+5ieAMpJAt1Fk+IfWLguEtZT7/xKVmtsRlgRESsf/3QJjKYYo0HwgWw
        LrSNZbQdyvPcNnVeUgZYTOc4cIOCnaC5ZP011AG6Cn1n1mtrMGNc1uIZencaADiSiwXOoK
        RRWrz5VFP7qiiu4bVOJGsPxq6yG0afTyN9zZc0Dcbyk5UscuvXOi34MDPVN5/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1687423889;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=11GWicbLpC0F9A4O6rye+3TFV+Z0pKuEfGbmi5Xihgc=;
        b=Ve1c4q2sKAtVICADuROmlUGEt5SFRidTNne8Y/DVygOVgESR5lDmwgOlo+HHq2uYtGIBR3
        GBkNjUNUDJh+T2Cg==
To:     Laurent Dufour <ldufour@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, x86@kernel.org,
        linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
        npiggin@gmail.com, christophe.leroy@csgroup.eu,
        dave.hansen@linux.intel.com, mingo@redhat.com, bp@alien8.de
Subject: Re: [PATCH 01/10] cpu/SMT: Move SMT prototypes into cpu_smt.h
In-Reply-To: <20230615154635.13660-2-ldufour@linux.ibm.com>
References: <20230615154635.13660-1-ldufour@linux.ibm.com>
 <20230615154635.13660-2-ldufour@linux.ibm.com>
Date:   Thu, 22 Jun 2023 10:51:29 +0200
Message-ID: <87o7l77ucu.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jun 15 2023 at 17:46, Laurent Dufour wrote:
> From: Michael Ellerman <mpe@ellerman.id.au>
>
> A subsequent patch would like to use the cpuhp_smt_control enum as part
> of the interface between generic and arch code.

This still has the 'patch' and 'arch' style which I pointed out
before. It seems you fixed it only for one patch in the series.

Thanks,

        tglx


