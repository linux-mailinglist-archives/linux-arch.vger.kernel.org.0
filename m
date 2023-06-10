Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF9A72AF60
	for <lists+linux-arch@lfdr.de>; Sun, 11 Jun 2023 00:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjFJWIO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 10 Jun 2023 18:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjFJWIN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 10 Jun 2023 18:08:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 720563A89;
        Sat, 10 Jun 2023 15:08:12 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686434889;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jVZzPX6ySJgTLx7rG1PlEmES+KNjRD+EkEdNbnlOS88=;
        b=b25T5Qe4kt5MEyfeX2GABqTnk9yjLItyquzWcx2uF0ipsqgMJo+Jd06bI9wtxSVxGwD/fg
        nz+i3ogEhNW+eOrE/+j7gQxfpsNLaPE4I9xtkoLRJjP1wegoLl4ky+Ib5h0qVFn3Ktwb71
        mcFIsaywBASu+DAaFu7RCo3rCLXQEaKGMXPEhuFLXkh6xtZXFhgu6gwACW9KC0awg7WVtW
        eNJ4emR5imFeA2He/z1nGztGSklYh3+dKykgJh/tmNsdAvW+EIDUBRGKFBpogE0EUkeT9F
        yKNajzrDDN7B3NN9z9N3qg6MEwP2ppmAgPDyQ17i45iAAjb3JHBsmFJ3XIxaSg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686434889;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jVZzPX6ySJgTLx7rG1PlEmES+KNjRD+EkEdNbnlOS88=;
        b=F0OuUI0fMxtyjvJSBkwniYXqfNSWA+CQmKGCPAp9LUuUIenY+Pb43ltP79gk0gHv6mQJtn
        Miqvo/wls8h5U9Bg==
To:     Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org,
        ldufour@linux.ibm.com, bp@alien8.de, dave.hansen@linux.intel.com,
        mingo@redhat.com, x86@kernel.org
Subject: Re: [PATCH 3/9] cpu/SMT: Store the current/max number of threads
In-Reply-To: <87fs6z80w5.ffs@tglx>
References: <20230524155630.794584-1-mpe@ellerman.id.au>
 <20230524155630.794584-3-mpe@ellerman.id.au> <87fs6z80w5.ffs@tglx>
Date:   Sun, 11 Jun 2023 00:08:09 +0200
Message-ID: <87a5x77yye.ffs@tglx>
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

On Sat, Jun 10 2023 at 23:26, Thomas Gleixner wrote:
> On Thu, May 25 2023 at 01:56, Michael Ellerman wrote:
>  /*
>   * The decision whether SMT is supported can only be done after the full
>   * CPU identification. Called from architecture code.
>   */
> -void __init cpu_smt_check_topology(void)
> +void __init cpu_smt_set_num_threads(unsigned int max_threads, unsigned int num_threads)
>  {
> -	if (!topology_smt_supported())
> +	if (max_threads == 1)

Which makes topology_smt_supported() redundant, i.e. it can be removed.

Thanks,

        tglx
