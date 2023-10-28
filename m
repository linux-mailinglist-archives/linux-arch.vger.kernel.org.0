Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE1027DA437
	for <lists+linux-arch@lfdr.de>; Sat, 28 Oct 2023 02:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbjJ1AEw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 27 Oct 2023 20:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbjJ1AEw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 27 Oct 2023 20:04:52 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6064F1B1
        for <linux-arch@vger.kernel.org>; Fri, 27 Oct 2023 17:04:49 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1cc30cfec53so2454975ad.3
        for <linux-arch@vger.kernel.org>; Fri, 27 Oct 2023 17:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1698451489; x=1699056289; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qU8qhN8NeuXvpuSaXXgUKByT7/WBJrVSQRx8q7qX/KU=;
        b=IzFwuiqF0vIsd6sQUZz//KGmaRks9/ic2ZYlgJQIaiJPnb/I9Zf3HHjyAFZftMo4w+
         un5Eaos9eqGarI0pgn78WP74qXjDyERr4xX4DLM8QQ8lB+T+4hY7vzddAn3+T+KRdcz4
         3y69EHVzpPbtuJY9XThMaxSe1/s0T7JGVk26mdlGUnfaMsP5waHsokfQBKQ2fWJdCSu6
         bQNFDK5AsKu5sqh3RRMLMDUwALZ9YYVua03bide/00azLbYjLs2yVS/1ZsuZcXzMWbpg
         LJjpdiIcMeqa2vVQiGSRrcvYXVDbm35ft4ljhtP3mnPG8/7v5/8Y16bfn76T5Lz9tUFc
         CdqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698451489; x=1699056289;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qU8qhN8NeuXvpuSaXXgUKByT7/WBJrVSQRx8q7qX/KU=;
        b=oiqhhsJAWZZbTV8ZLor4nCwg7qWElwW/Uckt8Wzm0xrGUIybeT7PHjXrvar4HoljBD
         E7oq2a1xXaNQ6dSeWxfxB/Oo8Es7BMGlB8wjYx0yWaFycjnkWGb1n6F6fPyfFfdPFPoC
         CZj4l2j+kczI3NfkjVLnVRB0S5JlQhFSHhac189MP/mZtfnB7dvWh/ztEt1b6u4DmXPl
         8I8hKHsqCz0rLEZKdVbLTeSo6cS9OnnVba16tiBt8+z8raGAeRrgcZ/Ib+HqvMEivUxM
         tGtHcsXhavqY1ZQAtBOeIauAl1VcN2fssgGuAQhKn/SZcpTosZxJvEKZLkNO4jn0jHRW
         F8tw==
X-Gm-Message-State: AOJu0Yx2W+vexuXzDEmZRhgjpgSerlvwTXgtwX7SN4MoX0EPk1F5c7KT
        uXcBKDENeZIYBqVIUbRdDWOv9g==
X-Google-Smtp-Source: AGHT+IHCWZUCOBrHeYHsbktRHjy1dwHh6CQjMh1NI3hlaxVuQBaSwOfSsn52ubFNnvm1Dp9H4oR9Aw==
X-Received: by 2002:a17:903:1385:b0:1cc:23ad:c2d5 with SMTP id jx5-20020a170903138500b001cc23adc2d5mr2905369plb.39.1698451488878;
        Fri, 27 Oct 2023 17:04:48 -0700 (PDT)
Received: from ghost ([12.44.203.122])
        by smtp.gmail.com with ESMTPSA id iz15-20020a170902ef8f00b001c9c6a78a56sm2136056plb.97.2023.10.27.17.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 17:04:48 -0700 (PDT)
Date:   Fri, 27 Oct 2023 17:04:45 -0700
From:   Charlie Jenkins <charlie@rivosinc.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor@kernel.org>,
        Samuel Holland <samuel.holland@sifive.com>,
        David Laight <David.Laight@aculab.com>,
        Xiao Wang <xiao.w.wang@intel.com>,
        Evan Green <evan@rivosinc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v8 1/5] asm-generic: Improve csum_fold
Message-ID: <ZTxQHVplimd4tquE@ghost>
References: <20231027-optimize_checksum-v8-0-feb7101d128d@rivosinc.com>
 <20231027-optimize_checksum-v8-1-feb7101d128d@rivosinc.com>
 <20231027231036.GM800259@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027231036.GM800259@ZenIV>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Oct 28, 2023 at 12:10:36AM +0100, Al Viro wrote:
> On Fri, Oct 27, 2023 at 03:43:51PM -0700, Charlie Jenkins wrote:
> >  /*
> >   * computes the checksum of a memory block at buff, length len,
> >   * and adds in "sum" (32-bit)
> > @@ -31,9 +33,7 @@ extern __sum16 ip_fast_csum(const void *iph, unsigned int ihl);
> >  static inline __sum16 csum_fold(__wsum csum)
> >  {
> >  	u32 sum = (__force u32)csum;
> > -	sum = (sum & 0xffff) + (sum >> 16);
> > -	sum = (sum & 0xffff) + (sum >> 16);
> > -	return (__force __sum16)~sum;
> > +	return (__force __sum16)((~sum - ror32(sum, 16)) >> 16);
> >  }
> 
> Will (~(sum + ror32(sum, 16))>>16 produce worse code than that?
> Because at least with recent gcc this will generate the exact thing
> you get from arm inline asm...

Yes that will produce worse code because an out-of-order processor will be able to
leverage that ~sum and ror32(sum, 16) can be computed independently of
each other. There are more strict data dependencies in (~(sum +
ror32(sum, 16))>>16.

- Charlie

