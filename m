Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF351205896
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jun 2020 19:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733007AbgFWR1D (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 23 Jun 2020 13:27:03 -0400
Received: from mga03.intel.com ([134.134.136.65]:17255 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732961AbgFWR1C (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 23 Jun 2020 13:27:02 -0400
IronPort-SDR: GFYQ7YSPjeYxhWokklsrMIaUddpka5Iniqp6dAqTi8QLIG+xX0N3s03LZGn86ejZ7TCZpmKcD/
 DfXaiQ0mr2UA==
X-IronPort-AV: E=McAfee;i="6000,8403,9661"; a="144171077"
X-IronPort-AV: E=Sophos;i="5.75,272,1589266800"; 
   d="scan'208";a="144171077"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2020 10:26:59 -0700
IronPort-SDR: dFkTC0Q3VbYtMwEZFits5/7wHj7dRqejoXJIagA8vcDlFKA9TiqfEssKP0af/RV+QvSnY0a5QI
 IIkrU34/15jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,272,1589266800"; 
   d="scan'208";a="478939562"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.152])
  by fmsmga005.fm.intel.com with ESMTP; 23 Jun 2020 10:26:58 -0700
Date:   Tue, 23 Jun 2020 10:26:58 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Marc Zyngier <maz@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-mips@vger.kernel.org, kvm@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ben Gardon <bgardon@google.com>,
        Peter Feiner <pfeiner@google.com>,
        Peter Shier <pshier@google.com>,
        Junaid Shahid <junaids@google.com>,
        Christoffer Dall <christoffer.dall@arm.com>
Subject: Re: [PATCH v2 00/21] KVM: Cleanup and unify kvm_mmu_memory_cache
 usage
Message-ID: <20200623172658.GF23842@linux.intel.com>
References: <20200622200822.4426-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200622200822.4426-1-sean.j.christopherson@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jun 22, 2020 at 01:08:01PM -0700, Sean Christopherson wrote:
> Note, patch 18 will conflict with the p4d rework in 5.8.  I originally
> stated I would send v2 only after that got pulled into Paolo's tree, but
> I got my timing wrong, i.e. I was thinking that would have already
> happened.  I'll send v3 if necessary.  I wanted to get v2 out there now
> that I actually compile tested other architectures.

Gah, too impatient by one day :-)  I'll spin v3 later in the week.
