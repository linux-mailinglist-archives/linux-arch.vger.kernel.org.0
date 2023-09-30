Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29CFF7B3E95
	for <lists+linux-arch@lfdr.de>; Sat, 30 Sep 2023 08:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232059AbjI3GJZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 30 Sep 2023 02:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232047AbjI3GJY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 30 Sep 2023 02:09:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D7E41A7;
        Fri, 29 Sep 2023 23:09:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2656CC433C7;
        Sat, 30 Sep 2023 06:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696054162;
        bh=uvjHAVtyz+cMLlBpiml8y8WpVPimcnEoijVRbGSv7y0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YyRBlWndR3KwVIYMarncmB/ymR7JLJrQUvl56+M+guaafrMTYE6eV9jnmINKz1Ngd
         mG2z7FNLyoFAkJfsX7netdXC6W9z6m+MOIPOY+TYgwcq12c5WGHsbQcBJT/2AvLXcJ
         ySpfKlnuIVN74VanHAw/DkBr+ZnInv5wVMyFTt3Q=
Date:   Sat, 30 Sep 2023 08:09:19 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org, patches@lists.linux.dev,
        mikelley@microsoft.com, kys@microsoft.com, wei.liu@kernel.org,
        haiyangz@microsoft.com, decui@microsoft.com,
        apais@linux.microsoft.com, Tianyu.Lan@microsoft.com,
        ssengar@linux.microsoft.com, mukeshrathor@microsoft.com,
        stanislav.kinsburskiy@gmail.com, jinankjain@linux.microsoft.com,
        vkuznets@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        will@kernel.org, catalin.marinas@arm.com
Subject: Re: [PATCH v4 13/15] uapi: hyperv: Add mshv driver headers defining
 hypervisor ABIs
Message-ID: <2023093057-eggplant-reshoot-8513@gregkh>
References: <1696010501-24584-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1696010501-24584-14-git-send-email-nunodasneves@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1696010501-24584-14-git-send-email-nunodasneves@linux.microsoft.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Sep 29, 2023 at 11:01:39AM -0700, Nuno Das Neves wrote:
> These must be in uapi because they will be used in the mshv ioctl API.
> 
> Version numbers for each file:
> hvhdk.h		25212
> hvhdk_mini.h	25294
> hvgdk.h		25125
> hvgdk_mini.h	25294

what are version numbers?

> These are unstable interfaces and as such must be compiled independently
> from published interfaces found in hyperv-tlfs.h.

uapi files can NOT be unstable, that's the opposite of an api :(

> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> Acked-by: Wei Liu <wei.liu@kernel.org>
> ---
>  include/uapi/hyperv/hvgdk.h      |   41 +
>  include/uapi/hyperv/hvgdk_mini.h | 1076 ++++++++++++++++++++++++
>  include/uapi/hyperv/hvhdk.h      | 1342 ++++++++++++++++++++++++++++++
>  include/uapi/hyperv/hvhdk_mini.h |  160 ++++
>  4 files changed, 2619 insertions(+)
>  create mode 100644 include/uapi/hyperv/hvgdk.h
>  create mode 100644 include/uapi/hyperv/hvgdk_mini.h
>  create mode 100644 include/uapi/hyperv/hvhdk.h
>  create mode 100644 include/uapi/hyperv/hvhdk_mini.h
> 
> diff --git a/include/uapi/hyperv/hvgdk.h b/include/uapi/hyperv/hvgdk.h
> new file mode 100644
> index 000000000000..9bcbb7d902b2
> --- /dev/null
> +++ b/include/uapi/hyperv/hvgdk.h
> @@ -0,0 +1,41 @@
> +/* SPDX-License-Identifier: MIT */

That's usually not a good license for a new uapi .h file, why did you
choose this one?

> +/* Define connection identifier type. */
> +union hv_connection_id {
> +	__u32 asu32;
> +	struct {
> +		__u32 id:24;
> +		__u32 reserved:8;
> +	} __packed u;

bitfields will not work properly in uapi .h files, please never do that.

thanks,

greg k-h
