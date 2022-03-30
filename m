Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE4314EBCEC
	for <lists+linux-arch@lfdr.de>; Wed, 30 Mar 2022 10:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244427AbiC3ItG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 30 Mar 2022 04:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242167AbiC3ItE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 30 Mar 2022 04:49:04 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3CB2AC07E;
        Wed, 30 Mar 2022 01:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wPfcvGoaLqJ0U7znxncjuzYbekQGXK1v+c9yOMjO0Nc=; b=iQO/dpFuFZOMpAC6r3kZDkXiFD
        gCOsI18AXPCMCis0vlOOS0XOvexSlJNElluMqSL7om/xPbOY+LWG6qGEg0v+BUDT1Reu8d73c0W3i
        EUw7bTwnVOozHuDLYbKS8tNSAtt1xdoAa03reNvqw6V43sAVgQPv7eMmBVTScyS92r08O+w1LT3rF
        EqOeJleHn+0orGRolOkd+dM4uURIKkJJynd1Z0i5zllZMm+yf8M8hUOMYOlsXhMVhhpSwlIxCLA43
        cuCuY4Fv3onFkpXyYuzQvU/33VcxnOfRK8mWRqnh9V8XCYY0Hw4ootxLPAe9UTIhDO7kuqj39Uy77
        UlDuZxFw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nZTy5-006AXR-PI; Wed, 30 Mar 2022 08:46:18 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id C0B01986215; Wed, 30 Mar 2022 10:46:15 +0200 (CEST)
Date:   Wed, 30 Mar 2022 10:46:15 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexander Potapenko <glider@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Christoph Hellwig <hch@lst.de>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Pekka Enberg <penberg@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 38/48] objtool: kmsan: list KMSAN API functions as
 uaccess-safe
Message-ID: <20220330084615.GH8939@worktop.programming.kicks-ass.net>
References: <20220329124017.737571-1-glider@google.com>
 <20220329124017.737571-39-glider@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220329124017.737571-39-glider@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Mar 29, 2022 at 02:40:07PM +0200, Alexander Potapenko wrote:
> KMSAN inserts API function calls in a lot of places (function entries
> and exits, local variables, memory accesses), so they may get called
> from the uaccess regions as well.

That's insufficient. Explain how you did the right thing and made these
functions actually safe to be called in this context.

> Signed-off-by: Alexander Potapenko <glider@google.com>
> ---
> Link: https://linux-review.googlesource.com/id/I242bc9816273fecad4ea3d977393784396bb3c35
> ---
>  tools/objtool/check.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index 7c33ec67c4a95..8518eaf05bff0 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -943,6 +943,25 @@ static const char *uaccess_safe_builtin[] = {
>  	"__sanitizer_cov_trace_cmp4",
>  	"__sanitizer_cov_trace_cmp8",
>  	"__sanitizer_cov_trace_switch",
> +	/* KMSAN */
> +	"kmsan_copy_to_user",
> +	"kmsan_report",
> +	"kmsan_unpoison_memory",
> +	"__msan_chain_origin",
> +	"__msan_get_context_state",
> +	"__msan_instrument_asm_store",
> +	"__msan_metadata_ptr_for_load_1",
> +	"__msan_metadata_ptr_for_load_2",
> +	"__msan_metadata_ptr_for_load_4",
> +	"__msan_metadata_ptr_for_load_8",
> +	"__msan_metadata_ptr_for_load_n",
> +	"__msan_metadata_ptr_for_store_1",
> +	"__msan_metadata_ptr_for_store_2",
> +	"__msan_metadata_ptr_for_store_4",
> +	"__msan_metadata_ptr_for_store_8",
> +	"__msan_metadata_ptr_for_store_n",
> +	"__msan_poison_alloca",
> +	"__msan_warning",
>  	/* UBSAN */
>  	"ubsan_type_mismatch_common",
>  	"__ubsan_handle_type_mismatch",
> -- 
> 2.35.1.1021.g381101b075-goog
> 
