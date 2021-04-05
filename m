Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A383A353B68
	for <lists+linux-arch@lfdr.de>; Mon,  5 Apr 2021 06:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbhDEExY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 5 Apr 2021 00:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbhDEExY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 5 Apr 2021 00:53:24 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C77C2C061756;
        Sun,  4 Apr 2021 21:53:17 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id v8so5101319plz.10;
        Sun, 04 Apr 2021 21:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZCE8DXq6AXOhvGcnEbPdIGiWxGR0DNPB4En9zD417Mo=;
        b=AjR104ethb/rIHzSnVpqVgi6EsTCzJaaUxnLpilWzQbcoMJU/+9r0Z9QHCdn842aO9
         agRr0cv9hjGTOhgosz26MQTAtZBwKLcvl0/7TkCsMnauaLGbmBS9EkD+SfteNM6H9huV
         c3uylhufMbXhGp6wnqw23rb6O3v4/+/gsrGBqbRHvHv40zCUbw9mTB/aT35baR6+SAUL
         dyiKy4friYGOoIxeN6pAwk/wVbwrvwFAwxD5B39n/Wz8aS7nvnSbmxahArC1dKFbdmUg
         l0aoUQxOsWkhvHwfrHeku6rWzWHCw3yr8/q4Oe6vqfCDHrEwoFPB83ECQVsc4mDQsX5r
         FewA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZCE8DXq6AXOhvGcnEbPdIGiWxGR0DNPB4En9zD417Mo=;
        b=ikA1T+W2VOKTTsvEZPkK567/LDTzjjNWL63PeEni9WDb8GlLA6RMUQQfES9dUgtzwm
         gnYynwgEQWADEZdqjJmOetzl80LeXwSQD2yx+1yZICu6RdCIKg2hKi0JonAVdXwb7GbA
         VPXNKHkx0erbRHD0BjUru/eQWw6TdydLPNzXQzAdWW2fDlHBilQl0TPtYQKI9yYiVeC1
         jqtYnvKsEkdRYwJaGEG2tpny3wbmYPuAn0efLqRj/UKVWP5c0ad/skIhBOXQ9shrRNMX
         rsoVTyC874F0GHnTnDydT6THKytkYdypipmP9+jz2fUn/HVm82BgXASzwZEf+j4VkhhP
         uB6w==
X-Gm-Message-State: AOAM531KqV/flUv0eWyboh/2iAFRI7EMfJb/dpsBOXwM545TUcOkffes
        Zt4OUeJwghrEPSJqrUIYlV8kEfH5CSsOUg==
X-Google-Smtp-Source: ABdhPJzfg2ojOFwwEAtuSC96RYvGRpvmKRNH0XexWPQ2Qhe5nU1HK9MGimRyUq/fHwj0Fqunx6onqA==
X-Received: by 2002:a17:90a:a108:: with SMTP id s8mr24898984pjp.199.1617598397085;
        Sun, 04 Apr 2021 21:53:17 -0700 (PDT)
Received: from gmail.com ([2601:600:8500:5f14:d627:c51e:516e:a105])
        by smtp.gmail.com with ESMTPSA id gm10sm14102358pjb.4.2021.04.04.21.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Apr 2021 21:53:16 -0700 (PDT)
Date:   Sun, 4 Apr 2021 21:50:50 -0700
From:   Andrei Vagin <avagin@gmail.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        dima@arista.com, arnd@arndb.de, tglx@linutronix.de,
        vincenzo.frascino@arm.com, luto@kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH RESEND v1 4/4] powerpc/vdso: Add support for time
 namespaces
Message-ID: <YGqXKkLDwDb589Qg@gmail.com>
References: <cover.1617209141.git.christophe.leroy@csgroup.eu>
 <1a15495f80ec19a87b16cf874dbf7c3fa5ec40fe.1617209142.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <1a15495f80ec19a87b16cf874dbf7c3fa5ec40fe.1617209142.git.christophe.leroy@csgroup.eu>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Mar 31, 2021 at 04:48:47PM +0000, Christophe Leroy wrote:
> This patch adds the necessary glue to provide time namespaces.
> 
> Things are mainly copied from ARM64.
> 
> __arch_get_timens_vdso_data() calculates timens vdso data position
> based on the vdso data position, knowing it is the next page in vvar.
> This avoids having to redo the mflr/bcl/mflr/mtlr dance to locate
> the page relative to running code position.
>

Acked-by: Andrei Vagin <avagin@gmail.com>
 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
