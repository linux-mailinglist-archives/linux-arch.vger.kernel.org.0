Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EAB2511965
	for <lists+linux-arch@lfdr.de>; Wed, 27 Apr 2022 16:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234875AbiD0Muy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 27 Apr 2022 08:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234709AbiD0Mux (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 27 Apr 2022 08:50:53 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B8BA1A3A5
        for <linux-arch@vger.kernel.org>; Wed, 27 Apr 2022 05:47:42 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id bg25so1080761wmb.4
        for <linux-arch@vger.kernel.org>; Wed, 27 Apr 2022 05:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4ZU7ssA0uBUIH6XIuoYvcPvJ99ZnRQPUGmPQtpNi76c=;
        b=IW2c9joHq/hwifhAacbBVc1qzogNoXNAxtBDcYWCPJ6fPOM9y6yKnxL7LpTymyi1Mw
         hjMcixIyPI70Pi2PTqQlosHfCg1E8SnZ5l0ArWRvMWodQsPK5LhTsudvfWJN9kI4hau8
         q0lDTsSvPRBac4hfb3TQ0orhvL6MUxOyjUvtvP5Yq/D4+mHZPSQn08XLD3G61YIjeSEa
         M4MO+l2LtH2/6N7jEwuGc9ZS+61BVh/gEjsKIastxGEQjzGbgP8+YNOkNsjzSS3tgsLX
         VM7ssK8zNESBLZCy1G0Aser5Eb5kq6GNeP6Wm6p+hwwD3361fyDBWfdauodf69g0q6sq
         eP3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4ZU7ssA0uBUIH6XIuoYvcPvJ99ZnRQPUGmPQtpNi76c=;
        b=P0nSKvxy/bc9/LB4owRSemfy2QJhHj2wqbjFMLz5tzsBTVglk5MeXc4eR4QUX4berK
         us/eBZLEddGaSXihX/ITnAGS5zhRm1iVWdUfpgz6TQv4NR6CiMBOiH1JBCNhbrLzM6CY
         PGbHYOmtOOp9aMcFBsngOUsWidFX1ORoQTgP6ETrEtCLyDFKFDg34AUzl/wG/ApUFWj3
         HwByH9LrpSEGT+ueEY9UwzCgIqz1VjsYQ/U9D/lI6rvJsPGCToIuIKTzbAW+w2EMdFRn
         98qQnz3EmH2wVwJ/JjcKDDC1/Qpi/xkJ1eqAEJeKxqbHNNgG+AqtigDvvknQJ2s5NMXQ
         rG3g==
X-Gm-Message-State: AOAM5304jB2DWeHDSrTzPUznG2uejbIaKUjXw/uTgRPdqA19lfbYUvIF
        odNuAsLAH57dlQoKoUmed9KMjA==
X-Google-Smtp-Source: ABdhPJz5NK+Ha567qr3bpxGvIn7U9ze3IwWfwIo5TY6HK+pg7ceZbULrFiJZ/aDUS4aMuFui3oFWlQ==
X-Received: by 2002:a05:600c:1584:b0:38e:c80e:b8b5 with SMTP id r4-20020a05600c158400b0038ec80eb8b5mr34457739wmf.99.1651063660964;
        Wed, 27 Apr 2022 05:47:40 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:15:13:493f:cd0f:324a:323c])
        by smtp.gmail.com with ESMTPSA id w12-20020adf8bcc000000b002060e3da33fsm13564171wra.66.2022.04.27.05.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 05:47:40 -0700 (PDT)
Date:   Wed, 27 Apr 2022 14:47:34 +0200
From:   Marco Elver <elver@google.com>
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
        Mark Rutland <mark.rutland@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 03/46] kasan: common: adapt to the new prototype of
 __stack_depot_save()
Message-ID: <Ymk7ZkkIq6rF+BmI@elver.google.com>
References: <20220426164315.625149-1-glider@google.com>
 <20220426164315.625149-4-glider@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220426164315.625149-4-glider@google.com>
User-Agent: Mutt/2.1.4 (2021-12-11)
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Apr 26, 2022 at 06:42PM +0200, Alexander Potapenko wrote:
> Pass extra_bits=0, as KASAN does not intend to store additional
> information in the stack handle. No functional change.
> 
> Signed-off-by: Alexander Potapenko <glider@google.com>

I think this patch needs to be folded into the previous one, otherwise
bisection will be broken.

> ---
> Link: https://linux-review.googlesource.com/id/I932d8f4f11a41b7483e0d57078744cc94697607a
> ---
>  mm/kasan/common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index d9079ec11f313..5d244746ac4fe 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -36,7 +36,7 @@ depot_stack_handle_t kasan_save_stack(gfp_t flags, bool can_alloc)
>  	unsigned int nr_entries;
>  
>  	nr_entries = stack_trace_save(entries, ARRAY_SIZE(entries), 0);
> -	return __stack_depot_save(entries, nr_entries, flags, can_alloc);
> +	return __stack_depot_save(entries, nr_entries, 0, flags, can_alloc);
>  }
>  
>  void kasan_set_track(struct kasan_track *track, gfp_t flags)
> -- 
> 2.36.0.rc2.479.g8af0fa9b8e-goog
> 
