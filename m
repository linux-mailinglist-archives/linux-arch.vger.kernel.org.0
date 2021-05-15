Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DDE5381A92
	for <lists+linux-arch@lfdr.de>; Sat, 15 May 2021 20:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbhEOSmb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 15 May 2021 14:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231558AbhEOSmb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 15 May 2021 14:42:31 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3318C061573;
        Sat, 15 May 2021 11:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=PQIE0/xjrN58EzSnLe1MpUaylEOcI28tzfG0NuGPhW8=; b=iO1uT6YnO8uxKVm2wxcF3WYNul
        uAaUbrslLEizhWDYdNR7LwUKsWLUO1Olv2CA+TObcrNqt4iIla6tkG5IwWCislQvoD0j53i0LqHjv
        b8ptjKptfRCNaNtJOv6jWO8cRgKwtZPjdFyYYU8cKCGBYV7PVvGdBEmeBjy/N5ml/SMr6VYet2Pgy
        AQs4fDkfpyeujLcrGrraUrgmq761V9f7WoZ/c0qqfE4O0eD3fjsA84K3chvMqK65NjBwa8kodst5s
        EOTAOuADapooaxtDRjovusrGjphJlDcg6yWw5uCtYM1owlvry28MLRGjY5moDTg50I75+ujsgXlm7
        Hes8sztg==;
Received: from [2601:1c0:6280:3f0::7376]
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lhzDt-00CeFt-ND; Sat, 15 May 2021 18:41:13 +0000
Subject: Re: [PATCH v2 12/13] asm-generic: uaccess: 1-byte access is always
 aligned
To:     Arnd Bergmann <arnd@kernel.org>, linux-arch@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Vineet Gupta <vgupta@synopsys.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
References: <20210514100106.3404011-1-arnd@kernel.org>
 <20210514100106.3404011-13-arnd@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <9f763da3-25c6-24e7-91e9-f3016a85f9f7@infradead.org>
Date:   Sat, 15 May 2021 11:41:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210514100106.3404011-13-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 5/14/21 3:01 AM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> With the cleaned up version of asm-generic/unaligned.h,
> there is a warning about the get_user/put_user helpers using
> unaligned access for single-byte variables:
> 
> include/asm-generic/uaccess.h: In function ‘__get_user_fn’:
> include/asm-generic/unaligned.h:13:15: warning: ‘packed’ attribute ignored for field of type ‘u8’ {aka ‘unsigned char’} [-Wattributes]
>   const struct { type x __packed; } *__pptr = (typeof(__pptr))(ptr); \
> 
> Change these to use a direct pointer dereference to avoid the
> warnings.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  include/asm-generic/uaccess.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/asm-generic/uaccess.h b/include/asm-generic/uaccess.h
> index 4973328f3c6e..7e903e450659 100644
> --- a/include/asm-generic/uaccess.h
> +++ b/include/asm-generic/uaccess.h
> @@ -19,7 +19,7 @@ __get_user_fn(size_t size, const void __user *from, void *to)
>  
>  	switch (size) {
>  	case 1:
> -		*(u8 *)to = get_unaligned((u8 __force *)from);
> +		*(u8 *)to = *((u8 __force *)from);
>  		return 0;
>  	case 2:
>  		*(u16 *)to = get_unaligned((u16 __force *)from);
> @@ -45,7 +45,7 @@ __put_user_fn(size_t size, void __user *to, void *from)
>  
>  	switch (size) {
>  	case 1:
> -		put_unaligned(*(u8 *)from, (u8 __force *)to);
> +		*(*(u8 *)from, (u8 __force *)to);

Should that be           from = 
?

>  		return 0;
>  	case 2:
>  		put_unaligned(*(u16 *)from, (u16 __force *)to);
> 


-- 
~Randy
