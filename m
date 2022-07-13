Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E175C57340B
	for <lists+linux-arch@lfdr.de>; Wed, 13 Jul 2022 12:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235887AbiGMKXF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 Jul 2022 06:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbiGMKXE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 Jul 2022 06:23:04 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD402FACAE
        for <linux-arch@vger.kernel.org>; Wed, 13 Jul 2022 03:23:01 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id b26so14842925wrc.2
        for <linux-arch@vger.kernel.org>; Wed, 13 Jul 2022 03:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=p3iDfE6X71ht0fb+AD37KbLhdKay+NMX0GxKDHXhdRo=;
        b=q5OYPMJHc5NTpTBzTnc2mfMCiWiuFAgpk/TjYZp6GcepMPcq5lgDiZ6LzuOUflA0jP
         mQ20OBCBA1dYRhBZlWXUYryRzuNxkRlU64ueE1Y3qgyhCS25l6CBUdFVPV/fyL6IUiPO
         CfdQF6vBqI2Y4rRVsv0spa8Dm9hA9W4jMIxk1PEOiQKIF9jWR6+J4PxJMbZelE4LxXkG
         U4TNOegzsfXO6Ejet7NiH1CF1VYsu6UgyAqkOZjOIS/Moqs10lM8FvGzfF5ouThkv9th
         Hxv7S6vuFyiAFwApfnhAwh4XA0kMaKq6XMsmFQxQ4Gb+0c8t6UgA/iG370Ot+63SoAg+
         nXKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=p3iDfE6X71ht0fb+AD37KbLhdKay+NMX0GxKDHXhdRo=;
        b=Z3YguKYH6Qa1OqrwfUNdqZx+2IbGNdp8WIrcft6afnmlhwb0zYpFtz3ksVP4UiQXO3
         P8/WTaBzxg/SZ9iQhNK/nfvBGEuMuie0c4Ah2GH9X4W5w1OUQLXLy7C6bxz2dXoUJ9ET
         fuCAgzw+FbSAXZU49JrjLJy6vrvu/fgTMI81zq6IAQTB3x0KsaRJbY8zqhdmXUUa0qCa
         9HbTg7gCplVDdumcmyY8dIf7hGWsG1sKp1+NXT6BafdsbI3oqj7xtd7FoRyzM9GIROU0
         JLWyA9HQDOQRNYQy5HQnHVwD8mkDt5TR1I1aLxxiOO16CE8IUDQ6Y6ZTm48SE3+js/8D
         AdGw==
X-Gm-Message-State: AJIora/Htrnq400cw1dbW2MkDqXBrM/JbcQacQO6wjUdrEMl0CGtFTuW
        Y+IsViccfmVhQLFnqVSyLIqiCQ==
X-Google-Smtp-Source: AGRyM1vP2cGTFHqS8DKrWw0AYUkMavOCEdacrjPpnfgTi5vrwimbctVkcDkN5Hi39rFjMQJqVgMbGw==
X-Received: by 2002:adf:f1d1:0:b0:21d:7f88:d638 with SMTP id z17-20020adff1d1000000b0021d7f88d638mr2542788wro.586.1657707780036;
        Wed, 13 Jul 2022 03:23:00 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:9c:201:63e6:a6c0:5e2a:ac17])
        by smtp.gmail.com with ESMTPSA id g6-20020a5d64e6000000b0021d887f9468sm10685642wri.25.2022.07.13.03.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 03:22:58 -0700 (PDT)
Date:   Wed, 13 Jul 2022 12:22:52 +0200
From:   Marco Elver <elver@google.com>
To:     Alexander Potapenko <glider@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexei Starovoitov <ast@kernel.org>,
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
        linux-kernel@vger.kernel.org, Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH v4 29/45] block: kmsan: skip bio block merging logic for
 KMSAN
Message-ID: <Ys6c/JYJlQjIfZtH@elver.google.com>
References: <20220701142310.2188015-1-glider@google.com>
 <20220701142310.2188015-30-glider@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220701142310.2188015-30-glider@google.com>
User-Agent: Mutt/2.2.3 (2022-04-12)
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jul 01, 2022 at 04:22PM +0200, 'Alexander Potapenko' via kasan-dev wrote:
[...]
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -867,6 +867,8 @@ static inline bool page_is_mergeable(const struct bio_vec *bv,
>  		return false;
>  
>  	*same_page = ((vec_end_addr & PAGE_MASK) == page_addr);
> +	if (!*same_page && IS_ENABLED(CONFIG_KMSAN))
> +		return false;
>  	if (*same_page)
>  		return true;

  	if (*same_page)
  		return true;
	else if (IS_ENABLED(CONFIG_KMSAN))
		return false;

>  	return (bv->bv_page + bv_end / PAGE_SIZE) == (page + off / PAGE_SIZE);
