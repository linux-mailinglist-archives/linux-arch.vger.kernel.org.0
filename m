Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2263A453CA6
	for <lists+linux-arch@lfdr.de>; Wed, 17 Nov 2021 00:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbhKPXYl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 Nov 2021 18:24:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbhKPXYk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 Nov 2021 18:24:40 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C144BC061570;
        Tue, 16 Nov 2021 15:21:42 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id s14so814993ilv.10;
        Tue, 16 Nov 2021 15:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zr4XRTWkj++PMy7FDY5s9w9BuZDTQwwlM/gCwIXxQb4=;
        b=bMnkobnHM7wSG8NdakeyUAsQ+1YSvi7VN2RCRMetqNSn8pd+bpHtvZaQ9bjBAOAb1+
         Nv31etULnCzQPmi6VKbg175JvN+UpGeyhmf9snwkIMTg8NxtG4Usm10BNyxOrKml7B7o
         r/4tR/nWhCUYDUVKeQzodPwtQ3WKTUZtbEloDU6qP8tC9BtJSljZtA1t9r+LVCsLgtVA
         vGVuKrV3U7aZQrN9BnzOK4hX5WhL8xTOLT+9dNZjcMH54Ak98N91WRhV+0dyixQ6EFNL
         X4wSNge8rRGZohlujorZWplEB4EIDiJLjDNWS+fhUXE+A/oOxcBQ2FYAzBwvtYSx6WNs
         Ittw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zr4XRTWkj++PMy7FDY5s9w9BuZDTQwwlM/gCwIXxQb4=;
        b=Ddnx/4P2FdjUkhThTgGhALGxXw4T8vFfjjdYgjQY5h+FWPn2aIDK06Qy3faup2aEKN
         +ZX8MvbL+HMy65UxPACld3sFEYLPdkc7L234LTZ8tdS1G6ZeVkwpjJjlAUSB4VZNmD0N
         AZhK5laVyC2T+h736/7zaVM8nfPT4mMKE3I1KrZB4M/YRZuDGZBZEEce2Cso4ZLe6U+i
         DDOc7gR9G52IIEHt1duJvNLB1tf06DlyIyKiRus9JjnmgSlImRVQqtqaNPi0ULXbLzWH
         LlWzPEkGWxS9jYOGcgzoy27OZkv79HLbkQyfKppsh15UkokDVP0Q4wcOMWQOMcwk/F8Q
         0lHA==
X-Gm-Message-State: AOAM5301kpuUB/+mos0ToN05RtUFMxY/EntxeUrq3nWS7t0cDRCZ193J
        dT2lX6SOVRjLWRz/eE5PZkg=
X-Google-Smtp-Source: ABdhPJzb58kPNJ9JAVz+8lf3NlozcjSIA552P+3lG/B0i+lw0NI8TtwtTne6wbUbTgb1I/44r8de9g==
X-Received: by 2002:a05:6e02:933:: with SMTP id o19mr7047887ilt.92.1637104902154;
        Tue, 16 Nov 2021 15:21:42 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id s15sm15192244ilu.16.2021.11.16.15.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 15:21:41 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailauth.nyi.internal (Postfix) with ESMTP id A5D7227C0054;
        Tue, 16 Nov 2021 18:21:37 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 16 Nov 2021 18:21:39 -0500
X-ME-Sender: <xms:AD2UYUk1RGISfHsE3AK3OKF1hZl-OEpOJ7F1fCYbOBUJlOcnAph8TQ>
    <xme:AD2UYT1iLNSxaegfzLko1Uundr7x3zHCiJrwZjOhpKpZ4LhrNErOfXBFbh6vKpbVL
    Vi3NQ3Nxz4JWkY2vQ>
X-ME-Received: <xmr:AD2UYSr6xKQ5LrUxJFNUNNy8hXpp8mEX767luv6fziRHhX257_OEYpgrj-yGww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrfeefgddtkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpedvleeigedugfegveejhfejveeuveeiteejieekvdfgjeefudehfefhgfegvdeg
    jeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedq
    udejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmh
    gvrdhnrghmvg
X-ME-Proxy: <xmx:AD2UYQmsO3BHlDZzWUwixNcS0TvaavYMTtyQPJ-G7hokW9GACx86qA>
    <xmx:AD2UYS0aiAgzNMBr-fF4ALpN_qT_im-lPU0goMDZi2X79bOSac9neQ>
    <xmx:AD2UYXsv2pGG-JG_UkbTHilTF3Ltma8C6LAkglvFh4Jr6OWMYDhFtw>
    <xmx:AT2UYV_bMWIETFN93Q1vizuKEzlPleJksVQIAKDI-aMvbzjodtLv2RtIs2M>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Nov 2021 18:21:36 -0500 (EST)
Date:   Wed, 17 Nov 2021 07:21:15 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Sunil Muthuswamy <sunilmut@linux.microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, maz@kernel.org, decui@microsoft.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, arnd@arndb.de, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
        Sunil Muthuswamy <sunilmut@microsoft.com>
Subject: Re: [PATCH v5 1/2] PCI: hv: Make the code arch neutral by adding
 arch specific interfaces
Message-ID: <YZQ86w4ALFg42Owo@boqun-archlinux>
References: <1636573510-23838-1-git-send-email-sunilmut@linux.microsoft.com>
 <1636573510-23838-2-git-send-email-sunilmut@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1636573510-23838-2-git-send-email-sunilmut@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Nov 10, 2021 at 11:45:09AM -0800, Sunil Muthuswamy wrote:
> From: Sunil Muthuswamy <sunilmut@microsoft.com>
> 
> Encapsulate arch dependencies in Hyper-V vPCI through a set of
> arch-dependent interfaces. Adding these arch specific interfaces will
> allow for an implementation for other architectures, such as arm64.
> 
> There are no functional changes expected from this patch.
> 

Other than the comment style nit, this patch looks good to me. Feel free
to add

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

> Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> ---
> In v2, v3, v4 & v5:
>  Changes are described in the cover letter. No change from v4 -> v5.
> 
>  arch/x86/include/asm/hyperv-tlfs.h  | 33 ++++++++++++
>  arch/x86/include/asm/mshyperv.h     |  7 ---
>  drivers/pci/controller/pci-hyperv.c | 79 ++++++++++++++++++++---------
>  include/asm-generic/hyperv-tlfs.h   | 33 ------------
>  4 files changed, 87 insertions(+), 65 deletions(-)
> 
> diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
> index 2322d6bd5883..fdf3d28fbdd5 100644
> --- a/arch/x86/include/asm/hyperv-tlfs.h
> +++ b/arch/x86/include/asm/hyperv-tlfs.h
> @@ -585,6 +585,39 @@ enum hv_interrupt_type {
>  	HV_X64_INTERRUPT_TYPE_MAXIMUM           = 0x000A,
>  };
>  
> +union hv_msi_address_register {
> +	u32 as_uint32;
> +	struct {
> +		u32 reserved1:2;
> +		u32 destination_mode:1;
> +		u32 redirection_hint:1;
> +		u32 reserved2:8;
> +		u32 destination_id:8;
> +		u32 msi_base:12;
> +	};
> +} __packed;
> +
> +union hv_msi_data_register {
> +	u32 as_uint32;
> +	struct {
> +		u32 vector:8;
> +		u32 delivery_mode:3;
> +		u32 reserved1:3;
> +		u32 level_assert:1;
> +		u32 trigger_mode:1;
> +		u32 reserved2:16;
> +	};
> +} __packed;
> +
> +/* HvRetargetDeviceInterrupt hypercall */
> +union hv_msi_entry {
> +	u64 as_uint64;
> +	struct {
> +		union hv_msi_address_register address;
> +		union hv_msi_data_register data;
> +	} __packed;
> +};
> +
>  #include <asm-generic/hyperv-tlfs.h>
>  
>  #endif
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
> index adccbc209169..c2b9ab94408e 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -176,13 +176,6 @@ bool hv_vcpu_is_preempted(int vcpu);
>  static inline void hv_apic_init(void) {}
>  #endif
>  
> -static inline void hv_set_msi_entry_from_desc(union hv_msi_entry *msi_entry,
> -					      struct msi_desc *msi_desc)
> -{
> -	msi_entry->address.as_uint32 = msi_desc->msg.address_lo;
> -	msi_entry->data.as_uint32 = msi_desc->msg.data;
> -}
> -
>  struct irq_domain *hv_create_pci_msi_domain(void);
>  
>  int hv_map_ioapic_interrupt(int ioapic_id, bool level, int vcpu, int vector,
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> index eaec915ffe62..03e07a4f0e3f 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -43,9 +43,6 @@
>  #include <linux/pci-ecam.h>
>  #include <linux/delay.h>
>  #include <linux/semaphore.h>
> -#include <linux/irqdomain.h>
> -#include <asm/irqdomain.h>
> -#include <asm/apic.h>
>  #include <linux/irq.h>
>  #include <linux/msi.h>
>  #include <linux/hyperv.h>
> @@ -583,6 +580,42 @@ struct hv_pci_compl {
>  
>  static void hv_pci_onchannelcallback(void *context);
>  
> +#ifdef CONFIG_X86
> +#define DELIVERY_MODE	APIC_DELIVERY_MODE_FIXED
> +#define FLOW_HANDLER	handle_edge_irq
> +#define FLOW_NAME	"edge"
> +
> +static int hv_pci_irqchip_init(void)
> +{
> +	return 0;
> +}
> +
> +static struct irq_domain *hv_pci_get_root_domain(void)
> +{
> +	return x86_vector_domain;
> +}
> +
> +static unsigned int hv_msi_get_int_vector(struct irq_data *data)
> +{
> +	struct irq_cfg *cfg = irqd_cfg(data);
> +
> +	return cfg->vector;
> +}
> +
> +static void hv_set_msi_entry_from_desc(union hv_msi_entry *msi_entry,
> +				       struct msi_desc *msi_desc)
> +{
> +	msi_entry->address.as_uint32 = msi_desc->msg.address_lo;
> +	msi_entry->data.as_uint32 = msi_desc->msg.data;
> +}
> +
> +static int hv_msi_prepare(struct irq_domain *domain, struct device *dev,
> +			  int nvec, msi_alloc_info_t *info)
> +{
> +	return pci_msi_prepare(domain, dev, nvec, info);
> +}
> +#endif // CONFIG_X86
> +
>  /**
>   * hv_pci_generic_compl() - Invoked for a completion packet
>   * @context:		Set up by the sender of the packet.
> @@ -1191,14 +1224,6 @@ static void hv_msi_free(struct irq_domain *domain, struct msi_domain_info *info,
>  	put_pcichild(hpdev);
>  }
>  
> -static int hv_set_affinity(struct irq_data *data, const struct cpumask *dest,
> -			   bool force)
> -{
> -	struct irq_data *parent = data->parent_data;
> -
> -	return parent->chip->irq_set_affinity(parent, dest, force);
> -}
> -
>  static void hv_irq_mask(struct irq_data *data)
>  {
>  	pci_msi_mask_irq(data);
> @@ -1217,7 +1242,6 @@ static void hv_irq_mask(struct irq_data *data)
>  static void hv_irq_unmask(struct irq_data *data)
>  {
>  	struct msi_desc *msi_desc = irq_data_get_msi_desc(data);
> -	struct irq_cfg *cfg = irqd_cfg(data);
>  	struct hv_retarget_device_interrupt *params;
>  	struct hv_pcibus_device *hbus;
>  	struct cpumask *dest;
> @@ -1246,7 +1270,7 @@ static void hv_irq_unmask(struct irq_data *data)
>  			   (hbus->hdev->dev_instance.b[7] << 8) |
>  			   (hbus->hdev->dev_instance.b[6] & 0xf8) |
>  			   PCI_FUNC(pdev->devfn);
> -	params->int_target.vector = cfg->vector;
> +	params->int_target.vector = hv_msi_get_int_vector(data);
>  
>  	/*
>  	 * Honoring apic->delivery_mode set to APIC_DELIVERY_MODE_FIXED by
> @@ -1347,7 +1371,7 @@ static u32 hv_compose_msi_req_v1(
>  	int_pkt->wslot.slot = slot;
>  	int_pkt->int_desc.vector = vector;
>  	int_pkt->int_desc.vector_count = 1;
> -	int_pkt->int_desc.delivery_mode = APIC_DELIVERY_MODE_FIXED;
> +	int_pkt->int_desc.delivery_mode = DELIVERY_MODE;
>  
>  	/*
>  	 * Create MSI w/ dummy vCPU set, overwritten by subsequent retarget in
> @@ -1377,7 +1401,7 @@ static u32 hv_compose_msi_req_v2(
>  	int_pkt->wslot.slot = slot;
>  	int_pkt->int_desc.vector = vector;
>  	int_pkt->int_desc.vector_count = 1;
> -	int_pkt->int_desc.delivery_mode = APIC_DELIVERY_MODE_FIXED;
> +	int_pkt->int_desc.delivery_mode = DELIVERY_MODE;
>  	cpu = hv_compose_msi_req_get_cpu(affinity);
>  	int_pkt->int_desc.processor_array[0] =
>  		hv_cpu_number_to_vp_number(cpu);
> @@ -1397,7 +1421,7 @@ static u32 hv_compose_msi_req_v3(
>  	int_pkt->int_desc.vector = vector;
>  	int_pkt->int_desc.reserved = 0;
>  	int_pkt->int_desc.vector_count = 1;
> -	int_pkt->int_desc.delivery_mode = APIC_DELIVERY_MODE_FIXED;
> +	int_pkt->int_desc.delivery_mode = DELIVERY_MODE;
>  	cpu = hv_compose_msi_req_get_cpu(affinity);
>  	int_pkt->int_desc.processor_array[0] =
>  		hv_cpu_number_to_vp_number(cpu);
> @@ -1419,7 +1443,6 @@ static u32 hv_compose_msi_req_v3(
>   */
>  static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
>  {
> -	struct irq_cfg *cfg = irqd_cfg(data);
>  	struct hv_pcibus_device *hbus;
>  	struct vmbus_channel *channel;
>  	struct hv_pci_dev *hpdev;
> @@ -1470,7 +1493,7 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
>  		size = hv_compose_msi_req_v1(&ctxt.int_pkts.v1,
>  					dest,
>  					hpdev->desc.win_slot.slot,
> -					cfg->vector);
> +					hv_msi_get_int_vector(data));
>  		break;
>  
>  	case PCI_PROTOCOL_VERSION_1_2:
> @@ -1478,14 +1501,14 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
>  		size = hv_compose_msi_req_v2(&ctxt.int_pkts.v2,
>  					dest,
>  					hpdev->desc.win_slot.slot,
> -					cfg->vector);
> +					hv_msi_get_int_vector(data));
>  		break;
>  
>  	case PCI_PROTOCOL_VERSION_1_4:
>  		size = hv_compose_msi_req_v3(&ctxt.int_pkts.v3,
>  					dest,
>  					hpdev->desc.win_slot.slot,
> -					cfg->vector);
> +					hv_msi_get_int_vector(data));
>  		break;
>  
>  	default:
> @@ -1594,14 +1617,14 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
>  static struct irq_chip hv_msi_irq_chip = {
>  	.name			= "Hyper-V PCIe MSI",
>  	.irq_compose_msi_msg	= hv_compose_msi_msg,
> -	.irq_set_affinity	= hv_set_affinity,
> +	.irq_set_affinity	= irq_chip_set_affinity_parent,
>  	.irq_ack		= irq_chip_ack_parent,
>  	.irq_mask		= hv_irq_mask,
>  	.irq_unmask		= hv_irq_unmask,
>  };
>  
>  static struct msi_domain_ops hv_msi_ops = {
> -	.msi_prepare	= pci_msi_prepare,
> +	.msi_prepare	= hv_msi_prepare,
>  	.msi_free	= hv_msi_free,
>  };
>  
> @@ -1625,12 +1648,12 @@ static int hv_pcie_init_irq_domain(struct hv_pcibus_device *hbus)
>  	hbus->msi_info.flags = (MSI_FLAG_USE_DEF_DOM_OPS |
>  		MSI_FLAG_USE_DEF_CHIP_OPS | MSI_FLAG_MULTI_PCI_MSI |
>  		MSI_FLAG_PCI_MSIX);
> -	hbus->msi_info.handler = handle_edge_irq;
> -	hbus->msi_info.handler_name = "edge";
> +	hbus->msi_info.handler = FLOW_HANDLER;
> +	hbus->msi_info.handler_name = FLOW_NAME;
>  	hbus->msi_info.data = hbus;
>  	hbus->irq_domain = pci_msi_create_irq_domain(hbus->fwnode,
>  						     &hbus->msi_info,
> -						     x86_vector_domain);
> +						     hv_pci_get_root_domain());
>  	if (!hbus->irq_domain) {
>  		dev_err(&hbus->hdev->device,
>  			"Failed to build an MSI IRQ domain\n");
> @@ -3535,9 +3558,15 @@ static void __exit exit_hv_pci_drv(void)
>  
>  static int __init init_hv_pci_drv(void)
>  {
> +	int ret;
> +
>  	if (!hv_is_hyperv_initialized())
>  		return -ENODEV;
>  
> +	ret = hv_pci_irqchip_init();
> +	if (ret)
> +		return ret;
> +
>  	/* Set the invalid domain number's bit, so it will not be used */
>  	set_bit(HVPCI_DOM_INVALID, hvpci_dom_map);
>  
> diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
> index 56348a541c50..45cc0c3b8ed7 100644
> --- a/include/asm-generic/hyperv-tlfs.h
> +++ b/include/asm-generic/hyperv-tlfs.h
> @@ -539,39 +539,6 @@ enum hv_interrupt_source {
>  	HV_INTERRUPT_SOURCE_IOAPIC,
>  };
>  
> -union hv_msi_address_register {
> -	u32 as_uint32;
> -	struct {
> -		u32 reserved1:2;
> -		u32 destination_mode:1;
> -		u32 redirection_hint:1;
> -		u32 reserved2:8;
> -		u32 destination_id:8;
> -		u32 msi_base:12;
> -	};
> -} __packed;
> -
> -union hv_msi_data_register {
> -	u32 as_uint32;
> -	struct {
> -		u32 vector:8;
> -		u32 delivery_mode:3;
> -		u32 reserved1:3;
> -		u32 level_assert:1;
> -		u32 trigger_mode:1;
> -		u32 reserved2:16;
> -	};
> -} __packed;
> -
> -/* HvRetargetDeviceInterrupt hypercall */
> -union hv_msi_entry {
> -	u64 as_uint64;
> -	struct {
> -		union hv_msi_address_register address;
> -		union hv_msi_data_register data;
> -	} __packed;
> -};
> -
>  union hv_ioapic_rte {
>  	u64 as_uint64;
>  
> -- 
> 2.25.1
> 
> 
