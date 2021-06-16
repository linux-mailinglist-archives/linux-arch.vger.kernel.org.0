Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB6AD3AA1D2
	for <lists+linux-arch@lfdr.de>; Wed, 16 Jun 2021 18:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbhFPQya (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 16 Jun 2021 12:54:30 -0400
Received: from mail-pj1-f52.google.com ([209.85.216.52]:56291 "EHLO
        mail-pj1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbhFPQya (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Jun 2021 12:54:30 -0400
Received: by mail-pj1-f52.google.com with SMTP id k7so2065225pjf.5;
        Wed, 16 Jun 2021 09:52:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8MKUHbuhcvvAbyVmhGO6tF9OydsRY8Yh0Heff4psMcU=;
        b=Qx1uZvn6htngZ1WWlJ23cxY8+02jmvVndZRS5HfNm6PhPMNmp8kyOwKrvxvWwGoine
         9pr3U2gpJQNLvBKbAIGO/1gYwBvjA5gjpCOilIOY+IA+sClaHqRlDfQj1XR4QwQ3FbW8
         3G5UvXz0vHQELf3NJ9fAZCjWKl9nkW5mwFOzFZhF3QZ7NMh95VMqeDbqDAFGrzGEO0BO
         s95K0r3Z7FEi+vssdwtjB5ZrXfbpPcEINoLNfGiEGmJKq33XXmHvYKR4sri872wUhPLj
         +4JmWQ1iApPivj/qrUmcVhxsign5XTu2hKmgxEu6zD5cr2llCvn+krPnGweV5rByC3PN
         yWPw==
X-Gm-Message-State: AOAM531oMH2N4zNWcyVBLilmcdDWzJnL8cabQWQ4b006bwS2MvsMoL1w
        /G0Qder6MW3ULapRNiqyittjfGjB7A0=
X-Google-Smtp-Source: ABdhPJyzx+UQa7eUy6fLX7IIzx1UxFuf2kpE8zutUL05jvc6Tbl3mGv+6//eteoO9Q90ulyVAqOUPQ==
X-Received: by 2002:a17:902:6a84:b029:f3:f285:7d8 with SMTP id n4-20020a1709026a84b02900f3f28507d8mr457172plk.57.1623862342073;
        Wed, 16 Jun 2021 09:52:22 -0700 (PDT)
Received: from [192.168.3.217] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id w7sm2574738pjy.11.2021.06.16.09.52.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jun 2021 09:52:21 -0700 (PDT)
Subject: Re: [dm-devel] [PATCH 06/18] bvec: add a bvec_kmap_local helper
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-arch@vger.kernel.org, linux-block@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Geoff Levand <geoff@infradead.org>,
        linuxppc-dev@lists.ozlabs.org, linux-mips@vger.kernel.org,
        Dongsheng Yang <dongsheng.yang@easystack.cn>,
        linux-kernel@vger.kernel.org,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        dm-devel@redhat.com, Ilya Dryomov <idryomov@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>, ceph-devel@vger.kernel.org
References: <20210615132456.753241-1-hch@lst.de>
 <20210615132456.753241-7-hch@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <244b92f2-7921-7f33-b83f-66f3fff57696@acm.org>
Date:   Wed, 16 Jun 2021 09:52:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210615132456.753241-7-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 6/15/21 6:24 AM, Christoph Hellwig wrote:
> +/**
> + * bvec_kmap_local - map a bvec into the kernel virtual address space
> + * @bvec: bvec to map
> + *
> + * Must be called on single-page bvecs only.  Call kunmap_local on the returned
> + * address to unmap.
> + */
> +static inline void *bvec_kmap_local(struct bio_vec *bvec)
> +{
> +	return kmap_local_page(bvec->bv_page) + bvec->bv_offset;
> +}

Hi Christoph,

Would it be appropriate to add WARN_ON_ONCE(bvec->bv_offset >=
PAGE_SIZE) in this function?

Thanks,

Bart.
