Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90D466B3AA3
	for <lists+linux-arch@lfdr.de>; Fri, 10 Mar 2023 10:34:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbjCJJeN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 10 Mar 2023 04:34:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbjCJJds (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 10 Mar 2023 04:33:48 -0500
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2067.outbound.protection.outlook.com [40.107.241.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B238726581;
        Fri, 10 Mar 2023 01:31:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N8KWlzbHT75e6Q+vnWlHdFSSdZ5D+k/NgWIyE41rX1RjW7NqldpPXVn7sx/8A+KlNZN40/OGm+Y1onvP/AzY05xLxQyUXDy27watfG3s7eFYTvpZI8oHvexV5q8IJOtRYOzlqjQcdVqP1T37lllbtmXGOF1YM3fuWx30y6Cw/FJmV+h9tNUJTkOsdHoASrJ9jR4muxJNlD+zouRkd850Xh7wTU76U1XsgT3lpyl2yaXpTHDyxsG7w3OuRJvCRSfD9J1TyZbACeKDgJ0gSqTZNjggzw+K3aWg1D8gdFTH/AERkjW9lZhPmWwWmubLba9NK2Gq/qn5E8UUTv/Xa+qcqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iXCI/7vsRcTmscDkipznTPSNzfW+QSFpaz8cYkId8BY=;
 b=Z7rCPnQ5KXBDC7adLZacr0pNgOyCPSwze4OfOF0ekH3PXsaqxshOEwqc3Te2wcal5dwakhonp6CkdZBVTcVnCooqeNhxCyPYxM6Lk1YukH7lqaqJO3e1UDx27E+VNpcCU1BXVUUFMgw7TbDtxzvP1URuw7g3RKUREGVjMZ5wu5SUY8p+QpJiIjcyraqH0ymmJWXB+aLd4fAho6Bt7r/3hq6lKTeUhAMKYSGLbRm1rsENotsQy441NOT1DQUyxpuWIeOEJHICYtE4DMNrCRUIz4dyRTFXMHoY/OrUAwIm4wYmkCIX11FY/ZTnUtriSxnhhmdZkH9CWI8VqJBb1JbeBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iXCI/7vsRcTmscDkipznTPSNzfW+QSFpaz8cYkId8BY=;
 b=e9FVAUsXAj+rk79b0+aupJix6toWCNek5OeoXqwhtO5IFFEC6qOXyfCmPU/Ei53fyAUcrP4x728IhSFkheWcwLBCyp2CmIDvnDf452qwea+bmPaNqAqIkIyJdcmTCCvHEr1s15Q7fDbRyHoVwCagtH3cHhzlRQ2OSdwKu3QFVa8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by AM9PR04MB8338.eurprd04.prod.outlook.com (2603:10a6:20b:3ec::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 09:30:51 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::29a3:120c:7d42:3ca8]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::29a3:120c:7d42:3ca8%7]) with mapi id 15.20.6178.019; Fri, 10 Mar 2023
 09:30:51 +0000
Date:   Fri, 10 Mar 2023 11:30:47 +0200
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] asm-generic/io.h: suppress endianness warnings for
 readq() and writeq()
Message-ID: <20230310093047.dneojlst5x4qqgwg@skbuf>
References: <20230109131153.991322-1-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230109131153.991322-1-vladimir.oltean@nxp.com>
X-ClientProxiedBy: BE1P281CA0027.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:15::18) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|AM9PR04MB8338:EE_
X-MS-Office365-Filtering-Correlation-Id: bae571f3-7878-4628-ab40-08db214a234f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LJWag+f9Fc1quROWCg8Xax5AeuGK95oQrCRCGobiUYgNFxY9Eh1c4t/Hne6hfdyWSndP+KzBsEghBKMg+Vddj3IOcTaNafRYmZqGL4AVOoHUJmQE+VrBfY2Zv4leNpAh/MFKEMGB2vo2m1epcLfckiflJkXt4PtOExcAgeNaH/I/xmc0uubJ4vhBU2t1DdnOYcQfTd2mCl2DNqJOfqXa4z0XHxqClyFE9VUcKV64TXcT1gN301ADpc4IAdCq3VYzNQIGfbvCZKyaZocLc2IQ6lFEjpNl37xcVwIv6LCu0+zTrUC07Tsyi0Dn6pm6lMmw0ddygkogHZ199SEirA3pkVjG0eBYw5PEPu82p1YVTUTzgnAlfa4WIgrlQvdkgRJx1uwml6raI1Vtd29zZbb/f7Kp8JFbBT0VqOUFNGlcV4aT0arbqz+PD84M59JtlkiCNGiMxzn2cRDmhTOfCf/raexBn/gM47WoB4yIVg+BTFJrDUuyOHv65LC4QzhOiVQopKrWg3im3VchcBKvwLbjfuP0Heff/z0s6kx0yA9Z+bClE978f/VhwtGt9Bi9baZAzUhNqOO9b50XMYMGoVR93tnW9KCIW1t2+SMgRCNLQ33SpihC2bZ7Ip/NYPZLwkhy1ZwKDUgIMmSbjPgCEIsEw8oX7FFsT8DFUPBNTeAPTfh8rSt6NxjcM4WCatUh9Xtl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(4636009)(376002)(136003)(366004)(346002)(39860400002)(396003)(451199018)(186003)(38100700002)(9686003)(86362001)(6506007)(6512007)(1076003)(26005)(83380400001)(6666004)(33716001)(8936002)(5660300002)(316002)(2906002)(478600001)(966005)(6486002)(6916009)(4326008)(41300700001)(66476007)(66946007)(8676002)(66556008)(44832011)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?trvstMQdkKEjeDl2ZE2QUeYdpTKSdcB04lWkPKmTFBS+7M49oYdS1Q2Jn51P?=
 =?us-ascii?Q?djztIeyj5+79gx+/apcfmq5ev2rDbm6JPb0wb77QWumIr0M0bG4nEuA+1loq?=
 =?us-ascii?Q?s08S5Tpdr1XPnyCSan7C/Sl6hTjOOm5J/j6jp4ut42fc5P/G2nBaLwqhXgZU?=
 =?us-ascii?Q?+7/w7oR2HHC3LN4AdCaHuT1WphUOnEXs3KOzDpkkYrzHrn96gFj2OkW9J6rW?=
 =?us-ascii?Q?OM3oYk1eQDZF7Sl7tUCYqL8olI3w0B2ay/HSs4jjMiEEWY+MP6wyPKd1wPdm?=
 =?us-ascii?Q?u18WZu8NHGCXjCDamhpOWFfhYHK3JmO/rQaB8rsPS+I04TAo50SI8n7wJVyU?=
 =?us-ascii?Q?AuL6/cEQmCHH932IEvKWhrWnerzi1Jkiz75JbEJMGXNa5Ewia+kfqn3CRFFF?=
 =?us-ascii?Q?L91hJtzNMpR3loihj3x8bl3iFTlLwUTmi2bKt2a+GIQN+5dMRJ5zDba7YIpk?=
 =?us-ascii?Q?ULWfUVA29JA1fa9lK95vCVgEpK3vuDoYAXiHjeTU+/AUknEwAol8Y8XsKWP6?=
 =?us-ascii?Q?yfryIU6JhelkKYdh4YTX8YptMyTifzF3msq5eHHivpXiEsRmiL1qsGcW0v9b?=
 =?us-ascii?Q?0Cm9d/n/WyOrtDuyV9P5dS2b1lPmOIemwfND4sCy+t4jmte5o9CIrnb15Sgt?=
 =?us-ascii?Q?F957J7nhkZiWUCygXzmZF2Ma9+SdNF5gAk/xR1r8UoR9Ve7kE52DsN0iBH1z?=
 =?us-ascii?Q?KYhtpGCXEQICTqq9d8Qti2puaUywyv4NG7CPgriuRe1T+Ubk1Hn5ccAEetjN?=
 =?us-ascii?Q?HakCUihrPV3nmbnDjcmjxh4BSMiyzPmVQTz70I0hHGGqsHII3u+CHzi3pfWo?=
 =?us-ascii?Q?uILk9iCcl0w5800V6M1ElRAgA8Gk6wgPpKun6xqdh+J/9KA9c2laoRNeSTHQ?=
 =?us-ascii?Q?UY7dXIhZCS+FJIv8WvGAdqd3vpNapJOkwgDUrvGlC8g8xBlq0+6MVuB1r937?=
 =?us-ascii?Q?JWzlVf3VFiHD2kRDIrIZ39ai6pt3Rx6YNmmyi4m7OcH2SoyEptN9ltxir0yi?=
 =?us-ascii?Q?YLutJPYSLFQFdteTTc7CACSf6XIxTEfqcdFdhczcA+DIswbNNM+Ur2DbL5dH?=
 =?us-ascii?Q?GqUxxd+okXc+vVhPHUigVcg1ROF7KCA6Y2JOxtrB+6O1h3TzwTyNsVP49hfc?=
 =?us-ascii?Q?4ibWtoqlMQgFhYvVKFQmGYLywavrMmALK4y1job3n6L6lTpWN1d6sl74zPZz?=
 =?us-ascii?Q?KtA8hemIjCMoyaSqQx3wyk1IM8KpEnCau8ErAMZkZFnKklq1aRvwO8twcrUV?=
 =?us-ascii?Q?Q6mXiRbgGfmzsKewrFso0+5hJgkHE/SLzOaHXoqLpHBhSZWtyQ+5ecXeyJyW?=
 =?us-ascii?Q?lPiNQiNtADj8pbr3BwbsJU/1oeOk0ahrKb7UIaBrz4zkegOs004zZ1K5zxTc?=
 =?us-ascii?Q?e/BMHdY3U9lAXS3S7Mkd+iKp4y1h7r71EC3yfywJkyPknOTzzBOOi0jpqpaZ?=
 =?us-ascii?Q?Hyv+QhsBrVechDRakOLIK3ROVV8/QxrcUMjPnpT4LaPxFnkHw4BpakuQozHd?=
 =?us-ascii?Q?jN+pCsYUhqI7SgiK+aKYx5rEeB0PF8Sdf4V0VOgzHMlKSjpvQT5nzLnFxttw?=
 =?us-ascii?Q?zLv4VoKyjrag8wgTXpMkqee2gnLltsk8oAQMYYWG9HmZMJJQNc/HMwLu8Ino?=
 =?us-ascii?Q?wg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bae571f3-7878-4628-ab40-08db214a234f
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 09:30:51.0839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3LctyhgtjZFD8npFpBwr/G4m8NGqDpq7k3eTRDyMo209NPnhlJ6q8bc1mkegPpk5JZahW7tG3tuiHParzzaAYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8338
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Arnd,

On Mon, Jan 09, 2023 at 03:11:52PM +0200, Vladimir Oltean wrote:
> Commit c1d55d50139b ("asm-generic/io.h: Fix sparse warnings on
> big-endian architectures") missed fixing the 64-bit accessors.
> 
> Arnd explains in the attached link why the casts are necessary, even if
> __raw_readq() and __raw_writeq() do not take endian-specific types.
> 
> Link: https://lore.kernel.org/lkml/9105d6fc-880b-4734-857d-e3d30b87ccf6@app.fastmail.com/
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
>  include/asm-generic/io.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
> index 4c44a29b5e8e..d78c3056c98f 100644
> --- a/include/asm-generic/io.h
> +++ b/include/asm-generic/io.h
> @@ -236,7 +236,7 @@ static inline u64 readq(const volatile void __iomem *addr)
>  
>  	log_read_mmio(64, addr, _THIS_IP_, _RET_IP_);
>  	__io_br();
> -	val = __le64_to_cpu(__raw_readq(addr));
> +	val = __le64_to_cpu((__le64 __force)__raw_readq(addr));
>  	__io_ar(val);
>  	log_post_read_mmio(val, 64, addr, _THIS_IP_, _RET_IP_);
>  	return val;
> @@ -287,7 +287,7 @@ static inline void writeq(u64 value, volatile void __iomem *addr)
>  {
>  	log_write_mmio(value, 64, addr, _THIS_IP_, _RET_IP_);
>  	__io_bw();
> -	__raw_writeq(__cpu_to_le64(value), addr);
> +	__raw_writeq((u64 __force)__cpu_to_le64(value), addr);
>  	__io_aw();
>  	log_post_write_mmio(value, 64, addr, _THIS_IP_, _RET_IP_);
>  }
> -- 
> 2.34.1
>

Did these patches get lost?
