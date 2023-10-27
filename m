Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A005A7DA3F8
	for <lists+linux-arch@lfdr.de>; Sat, 28 Oct 2023 01:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbjJ0XK7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 27 Oct 2023 19:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbjJ0XK6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 27 Oct 2023 19:10:58 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6780C1AA;
        Fri, 27 Oct 2023 16:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Aiw3atUCBnwgKNjOyjIprjoAJkJHCnLAHdffktGkr7w=; b=jEeP1VubOumA8I5tSAeXitLq9S
        XIjPJuii+LyAYcPZzu/YyatcPaREiQsauZJpKoDR8tKyT6Ry5XSpXFU7MnpsF5aF0pnga1UiB12O9
        blIxP8KjQ8abli6qVNuqcpd09O9gvHbqO8ADxmPKJHqhfeQwjvX6vWeOXcBBJDfx0PH8yWGzHxfna
        09cFAhe45cuJAfv31j2naLwl81N6OvJLVjsbZDDdY96DlRwu7uSWsqY7A/SIDbx6dNUI+8Fmwsq2I
        3A0oRt+eyWSv5DJs6Jvslfb/QF96Kyg4bbcmV1c9fz9cl9p25bnoedefZPNeN6OAosGDVOzuw6ZHx
        UdsrziBg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qwVyO-006mQG-2S;
        Fri, 27 Oct 2023 23:10:36 +0000
Date:   Sat, 28 Oct 2023 00:10:36 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Charlie Jenkins <charlie@rivosinc.com>
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
Message-ID: <20231027231036.GM800259@ZenIV>
References: <20231027-optimize_checksum-v8-0-feb7101d128d@rivosinc.com>
 <20231027-optimize_checksum-v8-1-feb7101d128d@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027-optimize_checksum-v8-1-feb7101d128d@rivosinc.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Oct 27, 2023 at 03:43:51PM -0700, Charlie Jenkins wrote:
>  /*
>   * computes the checksum of a memory block at buff, length len,
>   * and adds in "sum" (32-bit)
> @@ -31,9 +33,7 @@ extern __sum16 ip_fast_csum(const void *iph, unsigned int ihl);
>  static inline __sum16 csum_fold(__wsum csum)
>  {
>  	u32 sum = (__force u32)csum;
> -	sum = (sum & 0xffff) + (sum >> 16);
> -	sum = (sum & 0xffff) + (sum >> 16);
> -	return (__force __sum16)~sum;
> +	return (__force __sum16)((~sum - ror32(sum, 16)) >> 16);
>  }

Will (~(sum + ror32(sum, 16))>>16 produce worse code than that?
Because at least with recent gcc this will generate the exact thing
you get from arm inline asm...
